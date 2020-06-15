//
//  TimeModel.swift
//  Clima
//
//  Created by Lucas on 14/05/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct TimeModel {
    var time : String 
    var imagem: String {
        switch time{
        case "01"..."17" :
            return "light_background.pdf"
        case "18"..."23":
            return "dark_background.pdf"
        default:
            return "light_background.pdf"
        }
    }
    
}

