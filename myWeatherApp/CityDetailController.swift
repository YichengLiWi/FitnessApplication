//
//  CityDetailController.swift
//  myWeatherApp
//
//  Created by Sean Li on 12/19/17.
//  Copyright © 2017 Sean Li. All rights reserved.
//

import UIKit

class CityDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var namePassed:String = ""
    var doubleLatPassed:Double = 0.0
    var doubleLonPassed:Double = 0.0
    var datePassed:String = ""
    var tempPassed:Int=0
    var hourlyArrayDisplay: [(time_h: String, weather_h: String, temp_h:Int)] = []
    var unitPassed = false
    
    @IBOutlet weak var dayOneUILabel: UILabel!
    @IBOutlet weak var dayTwoUILabel: UILabel!
    @IBOutlet weak var dayThreeUILabel: UILabel!
    @IBOutlet weak var dayFourUILabel: UILabel!
    @IBOutlet weak var dayFiveUILabel: UILabel!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var hourlyTableView: UITableView!
    var coord:Coord?
    var city:City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        coord = Coord(lat: doubleLatPassed, lon: doubleLonPassed)
            city = City(coord: coord!)
            city!.getWeather()
            city!.getForecast()
        
        
        //view.backgroundColor = UIColor.init(red: 173, green: 216, blue: 230, alpha: 1)
        
        print(city!.forecastWeather?.city.name as Any)
        let degree = "°C"
        firstLabel.text = namePassed
        currentTempLabel.text = "\(city!.currentTemp())" + degree
        
        dateLabel.text = city!.currentDate()
        maxTempLabel.text = "\(city!.maxTemp())" + degree + " / " + "\(city!.minTemp())" + degree
        //self.hourlyTableView.register(UITableViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "HourlyTableViewCell")
        //need date, weather at noon, max,min temp
        let dailyDisplay = city!.getDaily()
        var tempStr = ""
        var dailyOutput = ""
        dayOneUILabel.lineBreakMode = .byWordWrapping
        dayOneUILabel.numberOfLines = 0
        dayOneUILabel.textAlignment = .center
        
//        dayOneUILabel.font = UIFont(name: "systemFont", size: 30)
        tempStr = "\(dailyDisplay[0].2)" + "/" +  "\(dailyDisplay[0].3)" + degree
        dailyOutput = dailyDisplay[0].0 + "\n" + dailyDisplay[0].1 + "\n" + tempStr
        dayOneUILabel.text = dailyOutput
        
        // make string spacing
        var attributedString = NSMutableAttributedString(string: dayOneUILabel.text!)
        var mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(4.0)
        
        if let stringLength = dayOneUILabel.text?.count {
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        dayOneUILabel.attributedText = attributedString
        
        dayTwoUILabel.lineBreakMode = .byWordWrapping
        dayTwoUILabel.numberOfLines = 0
        dayTwoUILabel.textAlignment = .center
//        dayTwoUILabel.font = UIFont(name: "systemFont", size: 30)
        tempStr = "\(dailyDisplay[1].2)" + "/" +  "\(dailyDisplay[1].3)" + degree
        dailyOutput = dailyDisplay[1].0 + "\n" + dailyDisplay[1].1 + "\n" + tempStr
        dayTwoUILabel.text = dailyOutput
        
        attributedString = NSMutableAttributedString(string: dayTwoUILabel.text!)
        mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(4.0)
        
        if let stringLength = dayTwoUILabel.text?.count {
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        dayTwoUILabel.attributedText = attributedString
        
        dayThreeUILabel.lineBreakMode = .byWordWrapping
        dayThreeUILabel.numberOfLines = 0
        dayThreeUILabel.textAlignment = .center
//        dayThreeUILabel.font = UIFont(name: "systemFont", size: 30)
        tempStr = "\(dailyDisplay[2].2)" + "/" +  "\(dailyDisplay[2].3)" + degree
        dailyOutput = dailyDisplay[2].0 + "\n" + dailyDisplay[2].1 + "\n" + tempStr
        dayThreeUILabel.text = dailyOutput
        
        attributedString = NSMutableAttributedString(string: dayThreeUILabel.text!)
        mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(4.0)
        
        if let stringLength = dayThreeUILabel.text?.count {
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        dayThreeUILabel.attributedText = attributedString
        
        dayFourUILabel.lineBreakMode = .byWordWrapping
        dayFourUILabel.numberOfLines = 0
        dayFourUILabel.textAlignment = .center
//        dayFourUILabel.font = UIFont(name: "systemFont", size: 30)
        tempStr = "\(dailyDisplay[3].2)" + "/" +  "\(dailyDisplay[3].3)" + degree
        dailyOutput = dailyDisplay[3].0 + "\n" + dailyDisplay[3].1 + "\n" + tempStr
        dayFourUILabel.text = dailyOutput
        
        attributedString = NSMutableAttributedString(string: dayFourUILabel.text!)
        mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(4.0)
        
        if let stringLength = dayFourUILabel.text?.count {
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        dayFourUILabel.attributedText = attributedString
        
        dayFiveUILabel.lineBreakMode = .byWordWrapping
        dayFiveUILabel.numberOfLines = 0
        dayFiveUILabel.textAlignment = .center
//        dayFiveUILabel.font = UIFont(name: "systemFont", size: 30)
        tempStr = "\(dailyDisplay[4].2)" + "/" +  "\(dailyDisplay[4].3)" + degree
        dailyOutput = dailyDisplay[4].0 + "\n" + dailyDisplay[4].1 + "\n" + tempStr
        dayFiveUILabel.text = dailyOutput
        
        attributedString = NSMutableAttributedString(string: dayFiveUILabel.text!)
        mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(4.0)
        
        if let stringLength = dayFiveUILabel.text?.count {
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        dayFiveUILabel.attributedText = attributedString
        
        
        //------------------------------Table View ------------------------------------//
        hourlyTableView.allowsSelection = false
        loadHourlyData()
        
    }
    
    func loadHourlyData() {
        let hourlyArray = city!.getHourly()
        hourlyArrayDisplay.append( (time_h: "Now", weather_h: (city!.openWeather?.weather[0].main)!, temp_h: city!.currentTemp()))
        for i in 0...hourlyArray.count-1 {
            //time, weather status, temp
            let (time, weather, temp) = city!.getHoulyIndex(index: i)
            hourlyArrayDisplay.append( (time_h: time, weather_h: weather, temp_h: temp))
        }
        
        hourlyTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyArrayDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HourlyTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HourlyTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let hourlyInfo = hourlyArrayDisplay[indexPath.row]
        
        cell.timeLabel.text = hourlyInfo.time_h
        cell.weatherLabel.text = hourlyInfo.weather_h
        cell.tempLabel.text = "\(hourlyInfo.temp_h)" + "°C"
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
