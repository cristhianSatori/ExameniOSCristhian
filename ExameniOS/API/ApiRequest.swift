//
//  ApiRequest.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import Foundation
import Alamofire
import UIKit.UIImage

class APIRequest {
    
    static func requestGet<T>(url: String, completion: @escaping (_ data: T?) -> Void) where T: Codable {
        AF.request(url, method: .get).responseDecodable { (response: DataResponse<T, AFError>) in
            debugPrint(response)
            if response.error != nil {
                NSLog("API error: \(String(describing: response.error))")
                completion(nil)
            } else {
                completion(response.value)
            }
        }
    }
    
}
