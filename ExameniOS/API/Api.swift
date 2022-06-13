//
//  Api.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import Alamofire

class Api {
    
    private static let url = "https://satoritech.com.mx/api/test"
    
    static func getInformation(completion: @escaping (_ response: ApiInfo?) -> Void){
        APIRequest.requestGet(url: url, completion: completion)
    }
        

}
