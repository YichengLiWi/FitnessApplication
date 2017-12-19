//
//  ForecastCity.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/18/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct ForecastCity: Decodable {
    var id: Int
    var name: String
    var coord: Coord
}
