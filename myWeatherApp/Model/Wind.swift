//
//  Wind.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/10/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct Wind: Decodable{
    var speed: Double
    var deg: Double
    var gust: Double
}
