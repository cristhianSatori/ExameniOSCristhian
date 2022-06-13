//
//  UserNameTableViewCell.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import UIKit


protocol UserNameTableViewCellDelegate {
    func setUserName(userName: String)
}

class UserNameTableViewCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var tfUser: UITextField!
    
    public var delegate: UserNameTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
    
    private func setupUI(){
        tfUser.delegate = self
    }
    
    private func isLetter(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let regEx = "([A-Z]*[a-z]*( )*)*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
         
//        if predicate.evaluate(with: string) || string == ""{
//
//            return true
//
//        }else if string == ""{
//
//            return true
//
//        }
        
        return predicate.evaluate(with: string) || string == ""
    }
    
}

extension UserNameTableViewCell: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        delegate?.setUserName(userName: tfUser.text ?? "")
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return isLetter(textField, shouldChangeCharactersIn: range, replacementString: string)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
    }
    
}

