//
//  NetworkServices.swift
//  AppWeather
//
//  Created by  MacOS on 09.08.2022.
//

import UIKit
import Alamofire

//MARK: - Protocol

protocol ViewModelDelegate {
    func updateWeather(weather:Response)
    func showError(error:String)
    //   func updateIcon(weather: Response)
}

//MARK: - VM

class ViewModel{
    var delegate:ViewModelDelegate? //ссылка на основной vc где все лейбы
    var locationCity:String?
    
    
  //MARK: - using Alamofire
    func getData()
    {
        if let city = locationCity{
        let urlString = "http://api.weatherstack.com/current?access_key=5491177b869b872ab5c98c7b991fbd05&query=\(city)&callback"
        
      //  print(urlString)
        APIManager.shared.getContent(apiLink: urlString) { response, error in
            if let error = error{self.delegate?.showError(error: error)}
            else{
                if let response = response{
                    
                    self.delegate?.updateWeather(weather: response)
                }
            }
            
        }
    }
    }
    
    //MARK: - using URLSession
    
//func getWeatherData(){
//    //заменить пробел на %
//    //locationCity.
// let urlString = "http://api.weatherstack.com/current?access_key=5491177b869b872ab5c98c7b991fbd05&query=\(locationCity)&callback"
//guard let url = URL(string: urlString) else { return }
//
//URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error {
//        print(error)
//        return
//    }
//    guard let data = data else { return }
//
//    let jsonString = String(data: data, encoding: .utf8)
//  //  print(jsonString)
//
//   if let datas = jsonString?.data(using: .utf8),
//      let result: Response = try? JSONDecoder().decode(Response.self, from: data){
// //   print("12341111111111\(result.location?.country)")
//    self.delegate?.updateWeather(weather: result)
//   }
//   else{
//    self.delegate?.showError(error: "error")
//   }
//
//
//
//
////   cityLabel.text = String(Location.CodingKeys.name)
//
//
//}.resume()
//
//
//}
    
}
