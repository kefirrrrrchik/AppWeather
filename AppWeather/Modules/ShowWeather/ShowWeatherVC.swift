//
//  ShowWeatherVC.swift
//  AppWeather
//
//  Created by  MacOS on 09.08.2022.
//

import UIKit
import Alamofire
import CoreLocation

class ShowWeatherVC: UIViewController, ViewModelDelegate {
   
    
    
    var lacationToURL: String?
    var cityName:String = ""
  //  var urlIm: Response
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windDirLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    @IBOutlet weak var buttonClose: UIButton!
    var viewModel:ViewModel?
    var imageString:String?
    var imageIcon:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel?.delegate = self
        viewModel?.locationCity = cityName
        viewModel?.getData()
        
        buttonClose.setCornerRadius(5)
        buttonClose.setBorder(width: 1, color: .red)
        
        // MARK: - image заглушка
       
//        let imageURL: NSURL = NSURL(string: "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png")!
//                let imageData:NSData = NSData(contentsOf: imageURL as URL)!
//                self.weatherIconImage.image = UIImage(data: imageData as Data)
               
        
       
        
        
        
    }
    
    //MARK: - goBack
    
    @IBAction private func buttonCloseDidTap(){
        dismiss(animated: true)
    }
    
    
    //MARK: - updateWeatherData
    func updateWeather(weather: Response) {
        cityLabel.text = "\(weather.location?.name ?? "")"
        timeLabel.text = "\(weather.location?.localtime ?? "")"
        windDirLabel.text = "\(weather.current?.wind_dir ?? "")"
        humidityLabel.text = "\(weather.current?.humidity ?? 0)"
        pressureLabel.text = "\(weather.current?.pressure ?? 0)"
        windSpeedLabel.text = "\(weather.current?.wind_speed ?? 0)"
        temperatureLabel.text = "\(weather.current?.temperature ?? 0)"
       // print("\(weather.current?.weather_icons)")
        imageString = weather.current?.weather_icons?.first
        
        DispatchQueue.global(qos: .userInitiated).async {
            //background thread code
            if let imgName = self.imageString,
             let imageURL = URL(string: imgName),
             let imageData = try? Data(contentsOf: imageURL){
                self.imageIcon = UIImage(data: imageData)
            }
            
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                if let imageIcon  = self.imageIcon{
                    self.weatherIconImage.image = imageIcon
                }
            }
        }
    }
    
    //MARK: - alert
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: "not found", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        present(alert, animated: true)
    }
    
    //MARK: - Image
//    func updateIcon(weather: Response) {
//        let imageURL: NSURL = NSURL(string: "\(weather.current?.weather_icons)")!
//        let imageData:NSData = NSData(contentsOf: imageURL as URL)!
//        self.weatherIconImage.image = UIImage(data: imageData as Data)
//        print("image")
//    }
    
}
