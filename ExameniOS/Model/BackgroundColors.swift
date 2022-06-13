//
//  BackgroundColors.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import FirebaseDatabase

class BackgroundColors {
    
    var mainScreenColor: String!
    var graphScreenColor: String!
    
    init() {}
    
    public func backgroundsFromSnapshot(snapshot: DataSnapshot){
        
        let value = snapshot.value as? NSDictionary
        self.mainScreenColor = value?["mainScreenColor"] as? String ?? ""
        self.graphScreenColor  = value?["graphScreenColor"] as? String ?? ""
        
    }
    
}
