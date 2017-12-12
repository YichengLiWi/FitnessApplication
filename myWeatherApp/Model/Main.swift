//
//  Main.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/10/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct Main: Decodable {
    var pressure: Double
    var temp: Double
    var humidity: Int
    var temp_max: Double
    var temp_min: Double
    
}
