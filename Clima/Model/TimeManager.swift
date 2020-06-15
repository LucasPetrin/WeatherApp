//
//  TimeManager.swift
//  Clima
//
//  Created by Lucas on 14/05/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit

protocol TimeModelDelegate {
    func didUpdateTime(_ timeManager: TimeManager, time: TimeModel)
    func didFailWithError(error: Error)
}

struct TimeManager {
    let timeURL = "https://www.amdoren.com/api/timezone.php?api_key=zyAfFfaLzdyQWVS7niPY723cWLHium"
    var delegate: TimeModelDelegate?
    
    func fetchTime(cityName: String) {
        let urlString = "\(timeURL)&loc=\(cityName)"
        let escapedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        performRequest(with: escapedUrlString!)
        
        
    }
    
    func performRequest(with escapedUrlString: String){
        //1- Create a URL
        if let url = URL(string: escapedUrlString){
            //2- Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3- Give the session a task and transform the output into a closure
            let task = session.dataTask(with: url) {(data,response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let time = self.parseJSON(safeData){
                        self.delegate?.didUpdateTime(self, time: time)
                    }
                }
                
                
            }
            
            //4- Star the task
            print (escapedUrlString)
            
            task.resume()
        }
    }
    
    func parseJSON(_ timeData: Data) -> TimeModel?{
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(TimeData.self, from: timeData)
            var time = decodedData.Time
            print (time)
            
            time.removeFirst(11)
            print (time)
            let timem = TimeModel(time: time)
            return timem
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
