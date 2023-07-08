//
//  APIManager.swift
//  AppWeather
//
//  Created by  MacOS on 10.08.2022.
//



import UIKit
import Alamofire

class APIManager{
    
    private init() {}
    static let shared = APIManager()
    
    
    func getContent(apiLink:String, _ completion:@escaping (Response?, String?) -> Void) {
        
    AF.request(apiLink).responseDecodable(of: Response.self) { (response) in
    guard let info = response.value
        else {
        completion(nil, "Parsing error")
        return
            }
        completion(info, nil) //передаем погоду в vc
        }
    }
}
