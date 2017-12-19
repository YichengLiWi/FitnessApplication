//
//  ForecastOpenWeatherMap.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/18/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

struct ForecastOpenWeatherMap: Decodable {
    //city name
    //day and date of today
    //Weather status
    //current temp, high, low
    //1 day forecast every 3 hours with weather status and temp
    // 4 day forecast; weather around noon of each day, the highest and the lowest temp of each day
    
    var city: ForecastCity
    var country: String?
    var cod: String
    var message: Double
    var cnt: Int
    var list: [ForecastWeather]
    
    func getCoordinate() -> Coord {
        return city.coord
    }
}
