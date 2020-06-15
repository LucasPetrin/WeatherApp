//
//  WeatherManager.swift
//  Clima
//
//  Created by Lucas on 13/05/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherModelDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

let weatherVC = WeatherViewController()

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=871e43605f40f46fe6370482d5f98176&units=metric&lang=pt_br"
    
    var delegate: WeatherModelDelegate?
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        let escapedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        performRequest(with: escapedUrlString!)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        let escapedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        performRequest(with: escapedUrlString!)
    }
    
    func performRequest(with escapedUrlString: String){
        
        //1- Create a URL
        if let url = URL(string: escapedUrlString) {
            
            //2 - Create a URL session
            let session = URLSession(configuration: .default)
            
            //3 - Give the session a task and tranform th output into a closure
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4- Start the task
            print (escapedUrlString)
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let temp_min = decodedData.main.temp_min
            let temp_max = decodedData.main.temp_max
            let pressure = decodedData.main.pressure
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, tempMin: temp_min, tempMax: temp_max, pressure: pressure)
            return weather
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}


