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
        if let dt = openWeather?.dt {
            let date = NSDate(timeIntervalSince1970: Double(dt))
            
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
            
            let dateString = dayTimePeriodFormatter.string(from: date as Date)

            return dateString
        }
        else {
            return ""
        }
    }
    
    func currentTemp() -> Int {
        if let openWeather = self.openWeather {
            return Int(openWeather.main.temp.rounded())
        }else {
            return 0
        }
    }
    
    func maxTemp() -> Int {
        if let openWeather = self.openWeather {
            return Int(openWeather.main.temp_max.rounded())
        }else {
            return 0
        }
    }
    
    func minTemp() -> Int {
        if let openWeather = self.openWeather {
            return Int(openWeather.main.temp_min.rounded())
        }else {
            return 0
        }
    }
    
    
    // Forecast Get
    func getTempMin() -> Int{
        return Int((self.forecastWeather?.list[0].main.temp_min.rounded())!)
    }
    
    func getCurrentForeTemp() -> Int{
        return Int((self.forecastWeather?.list[0].main.temp.rounded())!)
    }
    
    func getTempMax() -> Int {
        return Int((self.forecastWeather?.list[0].main.temp_max.rounded())!)
    }
    
    func getCurrentDate() -> String {
        let dt = self.forecastWeather?.list[0].dt
        let date = NSDate(timeIntervalSince1970: Double(dt!))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
    
    func getDate(index: Int) -> String {
        //let total = self.forecastWeather?.list.count
        
        if let dt = self.forecastWeather?.list[index].dt {
            let date = NSDate(timeIntervalSince1970: Double(dt))
            
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd"
            
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            return dateString
        }
        else {
            return ""
        }
    }
    
    func getHourly() -> [Int] {
        let today = getToday()
        var hourlyArray: [Int] = [Int]()
        var index:Int = 0
        while (getDate(index: index) == today) {
            hourlyArray.append(index)
            index += 1
        }
        return hourlyArray
    
    }
    
    func getDaily() -> [(String, String, Int, Int)] {
        var current = getToday()
        var index:Int = 0
        while ((index < (self.forecastWeather?.list.count)!) && (current == getDate(index:index))) {
            index += 1
        }
        current = getDate(index: index)
        let total = (self.forecastWeather?.list.count)! - 1
        var result: [(date_d: String, weather_d: String, maxTemp_d: Int, minTemp_d: Int)] = []
        var temp:(date_d: String, weather_d: String, maxTemp_d: Int, minTemp_d: Int) = ("", "", -99, 200)
        
        for index in index...total {
            if (getDate(index: index) == current) {
                temp.date_d = current
                if getTempMax(index: index) > temp.maxTemp_d {
                    temp.maxTemp_d = getTempMax(index: index)
                }
                if getTempMin(index: index) < temp.minTemp_d {
                    temp.minTemp_d = getTempMin(index: index)
                }
                if getTimeOnly(index:index) == "01:00 PM" {
                    temp.weather_d = self.forecastWeather!.list[index].weather[0].main
                }
            } else {
                result.append(temp)
                current = getDate(index: index)
                temp = (current, "", -99, 200)
            }
        }
        result.append(temp)
        
        return result
    }
    
    func getTempMin(index: Int) -> Int{
        return Int((self.forecastWeather?.list[index].main.temp_min.rounded())!)
    }
    
    func getTempMax(index: Int) -> Int {
        return Int((self.forecastWeather?.list[index].main.temp_max.rounded())!)
    }
    
    func getToday() -> String {
        let dt = openWeather!.dt
        let date = NSDate(timeIntervalSince1970: Double(dt))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
    
    func getHoulyIndex(index: Int) -> (String, String, Int) {
        let time = getTimeOnly(index: index)
        let weather_status = self.forecastWeather!.list[index].weather[0].main
        let temp = Int(self.forecastWeather!.list[index].main.temp.rounded())
        
        return(time, weather_status, temp)
    }
    
    func getTimeOnly(index:Int) -> String {
        let dt = self.forecastWeather?.list[index].dt
        let date = NSDate(timeIntervalSince1970: Double(dt!))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        print(dateString)
        return dateString
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
