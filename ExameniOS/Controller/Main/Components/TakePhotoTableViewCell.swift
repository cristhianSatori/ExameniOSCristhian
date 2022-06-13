//
//  TakePhotoTableViewCell.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import UIKit


protocol TakePhotoTableViewCellDelegate {
    func takeSelfie()
}

class TakePhotoTableViewCell: UITableViewCell, ReusableCell {

    public var delegate: TakePhotoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickTakeSelfie(_ sender: Any) {
        delegate?.takeSelfie()
    }
    
    
}
