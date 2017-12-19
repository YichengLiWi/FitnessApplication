//
//  OpenWeatherMap.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/10/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct OpenWeatherMap: Decodable {
    var coord: Coord
    var sys: Sys
    var base: String?
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var rain: Rain?
    var clouds:Cloud?
    var snow: Snow?
    var dt: Int
    var id: Int
    var name: String
    var cod: Int
 
}
