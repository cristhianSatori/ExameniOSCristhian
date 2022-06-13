//
//  GraphTableViewCell.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import UIKit

protocol GraphTableViewCellDelegate {
    func showGraphics()
}

class GraphTableViewCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var vwContent: UIView!
    
    public var delegate: GraphTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func setupUI(){
        
        vwContent.isUserInteractionEnabled = true
        vwContent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showGraphics)))
        
    }
    
    @objc
    private func showGraphics(){
        
        delegate?.showGraphics()
        
    }
}
