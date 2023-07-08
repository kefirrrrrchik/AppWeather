//
//  ViewController.swift
//  AppWeather
//
//  Created by  MacOS on 09.08.2022.
//

import UIKit
import CoreLocation
import MapKit

class FoundCityVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var labelCoordinates: UILabel!
    var city:String = ""
    var locationManager: CLLocationManager?
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet private weak var buttonShowWeather: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelCoordinates.setCornerRadius(5)
        labelCoordinates.setBorder(width: 1, color: .blue)

        buttonShowWeather.setCornerRadius(5)
        buttonShowWeather.setBorder(width: 1, color: .green)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        
    }
    
    //MARK: - stop updating coordinates(location)
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        locationManager?.stopUpdatingLocation()
//    }
 
    
    
    // MARK: - получение координат устройства и преобразование в название города
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first else {
            return
        }
        
//        self.labelCoordinates.text = "\(coordinate.coordinate.longitude) | \(coordinate.coordinate.latitude)"
       
        
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.coordinate.latitude, longitude:coordinate.coordinate.longitude)) { (places, error) in
            if error == nil{
                if let place = places{
                    //here you can get all the info by combining that you can make address
                    //   print("adres\(place)")
                    let pm = place as [CLPlacemark]
                    if pm.count > 0 {
                        let pm = place[0]
                        //  print(pm.country ?? "")
                        self.city = pm.locality!
                        self.labelCoordinates.text = "\(pm.locality ?? "sity")"
                    }
                }
            }
        }
        
    }
    
    //MARK: - faillocation
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERRRRR")
    }
    
    
    // MARK: - go to next VC
    
    @IBAction private func buttonShowWeatherDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showWeatherVC = storyboard.instantiateViewController(withIdentifier: "ShowWeatherVC") as! ShowWeatherVC
        //   showWeatherVC.locationManager = locationManager
        showWeatherVC.cityName = city 
        showWeatherVC.modalPresentationStyle = .fullScreen
        present(showWeatherVC, animated: true)
    }
    
}


