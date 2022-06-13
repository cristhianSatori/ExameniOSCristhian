//
//  Date+Extensions.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import Foundation


extension Date{
    
    func getCurrentDateString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
        
        return formatter.string(from: self)
        
    }
    
}

