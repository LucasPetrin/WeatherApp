//
//  CustomElements.swift
//  Clima
//
//  Created by Lucas on 14/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class CustomElements{
    //Comentario para gitHub
    
    
    
    func setShadows(elementsArray: [UIView]){
        
        for elemento in elementsArray {
            elemento.layer.shadowColor   = UIColor.darkGray.cgColor
            elemento.layer.shadowRadius  = 10
            elemento.layer.shadowOpacity = 1
            elemento.clipsToBounds       = false
            elemento.layer.masksToBounds = false
            
        }
        
    }
    
}




