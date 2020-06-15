//
//  WeatherData.swift
//  Clima
//
//  Created by Lucas on 13/05/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
}

struct Weather: Codable{
    let id: Int
    let description: String
    let main: String
}


