//
//  ViewController.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/10/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5b72c1517a6df4c2ff44267c84ca4670"
        guard let url = URL(string: jsonUrlString) else
            {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else {return}
            
//            let dataAsString = String (data: data, encoding: .utf8)
//            print(dataAsString)
            
            do {
                let weatherInfo = try JSONDecoder().decode(OpenWeatherMap.self, from:data)
                print(weatherInfo.name)
                print(weatherInfo.weather[0].description)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }.resume()
    }
}

