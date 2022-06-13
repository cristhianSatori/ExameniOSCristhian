//
//  DynamicGraphicsViewController.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 12/06/22.
//

import UIKit
import FirebaseDatabase

class DynamicGraphicsViewController: UIViewController {

    
    @IBOutlet var circleViews: [UIView]!
    @IBOutlet weak var cleanGraph: JPieChart!
    @IBOutlet weak var companyGraph: JPieChart!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblE1: UILabel!
    @IBOutlet weak var lblE2: UILabel!
    @IBOutlet weak var lblE3: UILabel!
    @IBOutlet weak var lblE4: UILabel!
    @IBOutlet weak var lblE5: UILabel!
    @IBOutlet weak var lblE6: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var vwContent: UIView!
    
    var dbRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        fetchInformation()
    }
    
    private func setupUI(){
        configureReference()
        setupCircleViews()
        setupSpinner()
    }
    
    private func setupCircleViews(){
        circleViews.forEach { (view) in
            view.layer.cornerRadius = view.bounds.width/2
        }
    }
    
    private func configureReference(){
        dbRef = Database.database().reference()
        
        dbRef.child("colors").observe(DataEventType.value, with: {[weak self] snapshot in
           
            let backgrounds = BackgroundColors()
            backgrounds.backgroundsFromSnapshot(snapshot: snapshot)
            
            self?.view.backgroundColor = UIColor(hex: backgrounds.graphScreenColor)
            
            
        })
    }
    
    private func setupSpinner(){
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    private func fetchInformation(){
        
        ApiInfo.getInfo(){[weak self] response in
            
            self!.spinner.stopAnimating()
            
            let yes = response!.cleaning[0].value!
            let no = response!.cleaning[1].value!
            
            self!.cleanGraph.lineWidth = 1
            self!.cleanGraph.addChartData(data: [
                JPieChartDataSet(percent: CGFloat(no), colors: [UIColor.red,UIColor.red]),
                JPieChartDataSet(percent: CGFloat(yes), colors: [UIColor.green,UIColor.green]),
            ])
            
            
            self!.lblYes.text = "Si \(yes)%"
            self!.lblNo.text = "No \(no)%"
            
            
            let e1 = response!.security[0].value!
            let e2 = response!.security[1].value!
            let e3 = response!.security[2].value!
            let e4 = response!.security[3].value!
            let e5 = response!.security[4].value!
            let e6 = response!.security[5].value!
            
            self!.companyGraph.lineWidth = 1
            self!.companyGraph.addChartData(data: [
                JPieChartDataSet(percent: CGFloat(e1), colors: [UIColor(named: "BlueGreenColor")!,UIColor(named: "BlueGreenColor")!]),
                JPieChartDataSet(percent: CGFloat(e2), colors: [UIColor.red,UIColor.red]),
                JPieChartDataSet(percent: CGFloat(e3), colors: [UIColor.orange,UIColor.orange]),
                JPieChartDataSet(percent: CGFloat(e4), colors: [UIColor(named: "DarkGreenColor")!,UIColor(named: "DarkGreenColor")!]),
                JPieChartDataSet(percent: CGFloat(e5), colors: [UIColor.yellow,UIColor.yellow]),
                JPieChartDataSet(percent: CGFloat(e6), colors: [UIColor.systemTeal,UIColor.systemTeal]),
            ])
            
            
            self!.lblE1.text = "\(response!.security[0].name!) \(e1)%"
            self!.lblE2.text = "\(response!.security[1].name!) \(e2)%"
            self!.lblE3.text = "\(response!.security[2].name!) \(e3)%"
            self!.lblE4.text = "\(response!.security[3].name!) \(e4)%"
            self!.lblE5.text = "\(response!.security[4].name!) \(e5)%"
            self!.lblE6.text = "\(response!.security[5].name!) \(e6)%"
            
        }
        
    }
}
