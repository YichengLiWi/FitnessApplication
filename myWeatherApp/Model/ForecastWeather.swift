//
//  ForecastWeather.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/18/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct ForecastWeather: Decodable{
    var dt: Int 
    var main: Main
    var weather: [Weather]
    var cloud: Cloud?
    var wind: Wind?
    var rain: Rain?
    var snow: Snow?
    var dt_txt: String
}
