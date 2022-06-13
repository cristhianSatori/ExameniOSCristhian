//
//  ViewController.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 12/06/22.
//

import UIKit
import FirebaseDatabase
import YPImagePicker
import FirebaseStorage

class ViewController: UIViewController {

    @IBOutlet weak var tvOptions: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var currentUserName: String?
    private var selfie: UIImage?
    var dbReference: DatabaseReference!
    let dbStorage = Storage.storage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI(){
        setupTableView()
        setupImageView()
        configureReference()
        setupSpinner()
    }
    

    private func configureReference(){
        dbReference = Database.database().reference()
        
        dbReference.child("colors").observe(DataEventType.value, with: {[weak self] snapshot in
           
            let backgrounds = BackgroundColors()
            backgrounds.backgroundsFromSnapshot(snapshot: snapshot)
            
            self?.view.backgroundColor = UIColor(hex: backgrounds.mainScreenColor)
            
            
        })
    }
    
    
    private func setupTableView(){
        
        tvOptions.dataSource = self
        tvOptions.rowHeight = UITableView.automaticDimension
        tvOptions.separatorStyle = .none
        tvOptions.separatorColor = .clear
        
        tvOptions.register(UINib(nibName: UserNameTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserNameTableViewCell.identifier)
            
        tvOptions.register(UINib(nibName: TakePhotoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TakePhotoTableViewCell.identifier)
        
        tvOptions.register(UINib(nibName: GraphTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GraphTableViewCell.identifier)
        
    }
    
    private func setupSpinner(){
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.stopAnimating()
    }
    
    private func setupImageView(){
        ivPhoto.isHidden = true
    }
    
    private func takeOrSelectSelfie(){
        
        let config = configureImage()
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.ivPhoto.isHidden = false
                self.selfie = photo.image
                self.ivPhoto.image = photo.image
            }
            
            picker.dismiss(animated: true)
            
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    public func configureImage()-> YPImagePickerConfiguration{
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = false
        config.albumName = "Examen iOS"
        config.onlySquareImagesFromCamera = false
        config.wordings.next = "Seleccione una opción"
        config.wordings.libraryTitle = "Galería"
        config.wordings.cameraTitle = "Cámara"
        config.wordings.cancel = "Cancelar"
        return config
    }
    
    @IBAction func onClickUpload(_ sender: Any) {
        
        let storageRef = dbStorage.reference()
        
        let data = selfie?.jpegData(compressionQuality: 1)
        
        if let userName = currentUserName{
            
            if let photo = data{
                let reference = storageRef.child("examen/\(userName)-\(Date().getCurrentDateString()).jpg")
                
                spinner.startAnimating()
                
                reference.putData(photo, metadata: nil){ (metadata, error) in
                    self.spinner.stopAnimating()
                    
                    guard let _ = metadata else { return }
                    
                    let alertController = UIAlertController (title: "¡Correcto!", message: "Imagen cargada correctamente." , preferredStyle: .alert)
                    
                    let settingsAction = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alertController.addAction(settingsAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            } else {
                
                let warningAlert = UIAlertController (title: "¡Advertencia!", message: "Por favor asegurese de tomar una selfie." , preferredStyle: .alert)
                
                let settings = UIAlertAction(title: "Aceptar", style: .default)
                
                warningAlert.addAction(settings)
                
                present(warningAlert, animated: true, completion: nil)
                
            }
            
        }else{
            
            let alertController = UIAlertController (title: "Aviso", message: "Por favor asegurese de ingresar el nombre de usuario." , preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Aceptar", style: .default)
            
            alertController.addAction(settingsAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: UserNameTableViewCell.identifier,
                    for: indexPath
                ) as! UserNameTableViewCell
                
                cell.delegate = self
                
                return cell
                
            case 1:
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: TakePhotoTableViewCell.identifier,
                    for: indexPath
                ) as! TakePhotoTableViewCell
                
                cell.delegate = self
                
                return cell
                
            case 2:
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: GraphTableViewCell.identifier,
                    for: indexPath
                ) as! GraphTableViewCell
                
                cell.delegate = self
                
                return cell
                
            default:
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: UserNameTableViewCell.identifier,
                    for: indexPath
                ) as! UserNameTableViewCell
                
                return cell
            
            
        }
        
    }
    
}

extension ViewController: UserNameTableViewCellDelegate{
    
    func setUserName(userName: String) {
        currentUserName = userName
    }
    
    
}

extension ViewController: TakePhotoTableViewCellDelegate{
    
    func takeSelfie() {
        let alertController = UIAlertController (title: "Aviso", message: "¿Desea tomar o seleccionar una fotografía?." , preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Aceptar", style: .default) { (_) -> Void in
            
            self.takeOrSelectSelfie()
        }
        
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}

extension ViewController: GraphTableViewCellDelegate{
    
    func showGraphics() {
        let vc =  UIStoryboard(name: "Graphics", bundle: nil).instantiateViewController(withIdentifier: "DynamicGraphicsViewController")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
