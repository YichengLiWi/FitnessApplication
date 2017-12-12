//
//  Weather.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/10/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
}
