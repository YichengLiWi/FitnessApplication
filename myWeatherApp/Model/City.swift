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
    var openWeather: OpenWeatherMap?
    //forecastWeather
    var forecastWeather: ForecastOpenWeatherMap?
    var coord: Coord
    
    
    init(coord: Coord) {
        self.coord = coord
    }
    
    func getWeather(){
            self.parseWeatherAPI(coordinate: coord)
    }
    
    func getForecast(){
            self.parseForeCastWeatherAPI(coordinate: coord)
    }
    
    func setForecastWeather(forecastWeather: ForecastOpenWeatherMap) {
        self.forecastWeather = forecastWeather
    }
    
    func getCoordinate() -> Coord {
        return self.openWeather!.coord
    }
    
    func currentDate() -> String {
        let dt = openWeather!.dt
        let date = NSDate(timeIntervalSince1970: Double(dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)

        return dateString
    }
    
    func currentTemp() -> Int {
        return Int(self.openWeather!.main.temp.rounded())
    }
    
    func addCity(new_city_coord: Coord) {
        parseWeatherAPI(coordinate: new_city_coord)
        //when can I store the info to the city; should I initialize new var in parseWeatherAPI?
        parseForeCastWeatherAPI(coordinate: new_city_coord)
    }
    // delete city parameter index
    
    
    
    // use urlSession get OpenWeatherMap url's content
    func parseWeatherAPI(coordinate: Coord) {
        let lat = coordinate.lat
        let lon = coordinate.lon
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=5b72c1517a6df4c2ff44267c84ca4670&units=metric"
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK            
            guard let data = data else {return}
            
            print("data got")
            //            let dataAsString = String (data: data, encoding: .utf8)
            //            print(dataAsString)
            self.updateWeatherData(data: data)
            
            }.resume()
        
         sleep(1)
    }
    
    // use urlSession get ForecastOpenWeatherMap url's content
    func parseForeCastWeatherAPI(coordinate: Coord) {
        let lat = coordinate.lat
        let lon = coordinate.lon
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=5b72c1517a6df4c2ff44267c84ca4670&units=metric"
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else {return}
            
            print("data got")
            //            let dataAsString = String (data: data, encoding: .utf8)
            //            print(dataAsString)
            self.updateForecastWeatherData(data: data)
            
            }.resume()
        
        sleep(1)

    }
    
    
    func updateWeatherData(data: Data) {
        print("store data")
        
        do {
            let weatherInfo = try JSONDecoder().decode(OpenWeatherMap.self, from:data)
            print(weatherInfo.name)
            print(weatherInfo.weather[0].description)
            self.openWeather = weatherInfo
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
            
        }
    }
    
    func updateForecastWeatherData(data: Data) {
        print("store forecast data")
        
        do {
            let weatherInfo = try JSONDecoder().decode(ForecastOpenWeatherMap.self, from:data)
            self.forecastWeather = weatherInfo
//            let coord_forecast = weatherInfo.getCoordinate()
//            for city in cities {
//                let coord_city = city.getCoordinate()
//                if (coord_city.lat == coord_forecast.lat) && (coord_city.lon == coord_forecast.lon) {
//                    city.setForecastWeather(forecastWeather: weatherInfo)
//                }
//            }
            //self.cities.append(city)
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
            
        }
    }
}
