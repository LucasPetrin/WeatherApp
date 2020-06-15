//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var downTempIcon: UIImageView!
    @IBOutlet weak var upTempIcon: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    
    //var timeManager = TimeManager()

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    let customElements = CustomElements()
    var elementsArray: [UIView] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timeManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        loadShadows()

    }
    
    
    func didFailWithError(error: Error) {
        showErrorAlert(message: "Não achei nada, digita de novo?")
    }
    
    
    @IBAction func getLocation(_ sender: Any) {
        
        //timeManager.fetchTime(cityName: cityLabel.text!)

        searchTextField.resignFirstResponder()
        searchTextField.text = nil
        locationManager.requestLocation()
    }
    
    func loadShadows(){

        elementsArray.append(conditionImageView)
        elementsArray.append(cityLabel)
        elementsArray.append(temperatureLabel)
        elementsArray.append(tempMaxLabel)
        elementsArray.append(tempMinLabel)
        elementsArray.append(upTempIcon)
        elementsArray.append(downTempIcon)
        elementsArray.append(pressureLabel
        )
        customElements.setShadows(elementsArray: elementsArray)

    }
    
    
    func showErrorAlert(message: String ){
        
        DispatchQueue.main.async {
            
            // create the alert
            let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        if let city = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            locationManager.stopUpdatingLocation()
            weatherManager.fetchWeather(cityName: city)
            // timeManager.fetchTime(cityName: city)
        }
        
        searchTextField.resignFirstResponder()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        return true
    }
    
}

//MARK: - WeatherModelDelegate

extension WeatherViewController: WeatherModelDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.tempMinLabel.text = weather.temperatureMinString
            self.tempMaxLabel.text = weather.temperatureMaxString
            self.pressureLabel.text = String(weather.pressure)
        }
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        locationManager.desiredAccuracy = 3
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}

//MARK: - TimeModelDelegate

//extension WeatherViewController: TimeModelDelegate {
//
//    func didUpdateTime(_ timeManager: TimeManager, time: TimeModel) {
//        DispatchQueue.main.async{
//            UIView.transition(with: self.backgroundImageView,
//                              duration: 0.5,
//                              options: .transitionCrossDissolve,
//                              animations: {
//                                self.backgroundImageView.image = UIImage(named: time.imagem)
//
//            }, completion: nil)
//
//        }
//    }


//        func didFailWithError(error: Error) {
//
//            DispatchQueue.main.async{
//
//                var mensagemDoAlerta: String{
//                    switch self.time.currentTime {
//                    case nil:
//                        return "Erro ao obter a hora do local :("
//                    default:
//                       return "Erro ao obter dados do servidor :("
//                    }
//                }
//
//                print(error)
//            }
//
//           showErrorAlert(message: mensagemDoAlerta)
//        }
//
//}



