//
//  Cities.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/18/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import Foundation

// list view and detail view both fetch data from here
struct Cities {
    
    // array of cities [City] - city has openWeatherMap and forecastWeather
    var cities: [City]
    
    // initializer add current city to the array
    func Cities() {
        //find current city
        //testing purpose
        var coordinates = [Coord]()
        let cities = [(40.7, -74.0), (34.05, -118.24), (41.87, -87.6), (29.76, -95.36), (32.75, -117.16)]
        for city in cities {
            let temp = Coord(lat: city.0, lon: city.1)
            coordinates.append(temp)
        }
        for coordinate in coordinates {
            parseWeatherAPI(coordinate: coordinate)
        }
        
    }
    
    // add city parameter Coord
    // to call two APIs add openWeatherMap,and forecastWeather info
    func addCity(new_city_coord: Coord) {
        parseWeatherAPI(coordinate: new_city_coord)
        //when can I store the info to the city; should I initialize new var in parseWeatherAPI?
        parseForeCastWeatherAPI(coordinate: new_city_coord)
    }
    // delete city parameter index

    
    func parseWeatherAPI(coordinate: Coord) {
        let lat = coordinate.lat
        let lon = coordinate.lon
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=5b72c1517a6df4c2ff44267c84ca4670"
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else {return}
            
            //            let dataAsString = String (data: data, encoding: .utf8)
            //            print(dataAsString)
            
            do {
                let weatherInfo = try JSONDecoder().decode(OpenWeatherMap.self, from:data)
                print(weatherInfo.name)
                print(weatherInfo.weather[0].description)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                
            }
            }.resume()
    }
    
    func parseForeCastWeatherAPI(coordinate: Coord) {
        
    }
}
