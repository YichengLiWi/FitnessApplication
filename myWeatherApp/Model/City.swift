//
//  City.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/10/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

class City
{
    var openWeather: OpenWeatherMap
    //forecastWeather
    var forecastWeather: ForecastOpenWeatherMap?
    
    init(openWeather: OpenWeatherMap) {
        self.openWeather = openWeather
        self.forecastWeather = nil
    }
    
    func setForecastWeather(forecastWeather: ForecastOpenWeatherMap) {
        self.forecastWeather = forecastWeather
    }
    
    func getCoordinate() -> Coord {
        return self.openWeather.coord
    }
    
    func currentDate() -> String {
        let dt = openWeather.dt
        let date = NSDate(timeIntervalSince1970: Double(dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)

        return dateString
    }
    
    func currentTemp() -> Int {
        return Int(self.openWeather.main.temp.rounded())
    }
}
