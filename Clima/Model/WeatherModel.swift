//
//  WeatherModel.swift
//  Clima
//
//  Created by Lucas on 14/05/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    
    var temperatureString: String{
        return String(format: "%.0f", temperature)+"ºC"
    }
    
    var temperatureMinString: String{
        return String(format: "%.0f", tempMin)+"ºC"
    }
    
    var temperatureMaxString: String{
        return String(format: "%.0f", tempMax)+"ºC"
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
