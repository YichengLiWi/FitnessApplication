//
//  City.swift
//  cityView
//
//  Created by Ray Fan on 12/18/17.
//  Copyright © 2017 Ray Fan. All rights reserved.
//

import UIKit
import os.log

class CityList: NSObject, NSCoding{
    
    //MARK: Properties
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cities")
    
    var name: String
    var lat: Double
    var lon: Double
    var temp: Int
    var current: Int

    
    init?(name: String, lat: Double, lon: Double, temp: Int, current: Int){
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.lat = lat
        self.lon = lon
        self.temp = temp
        self.current = current
        
    }
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let lat = "lat"
        static let lon = "lon"
        static let temp = "temp"
        static let current = "current"
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a City object.", log: OSLog.default, type: .debug)
            return nil
        }
        let lat = aDecoder.decodeDouble(forKey: PropertyKey.lat)
        let lon = aDecoder.decodeDouble(forKey: PropertyKey.lon)
        let temp = aDecoder.decodeInteger(forKey: PropertyKey.temp)
        let current = aDecoder.decodeInteger(forKey: PropertyKey.current)
        
        
        self.init(name: name, lat: lat, lon: lon, temp: temp, current: current)
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(lat, forKey: PropertyKey.lat)
        aCoder.encode(lon, forKey: PropertyKey.lon)
        aCoder.encode(temp, forKey: PropertyKey.temp)
        aCoder.encode(current, forKey: PropertyKey.current)
    }
    
    
    
    
}

