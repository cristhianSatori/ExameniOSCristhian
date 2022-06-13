//
//  ApiInfo.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

struct ApiInfo : Codable{
    
    let security: [SecurityInfo]!
    let cleaning: [CleaningInfo]!
    
    static func getInfo(completion: @escaping (_ response: ApiInfo?) -> Void){
        Api.getInformation(completion: completion)
    }
}

struct SecurityInfo : Codable{
    
    let name: String!
    let value: Int!
    
    
}

struct CleaningInfo : Codable{
    
    let name: String!
    let value: Int!
}
