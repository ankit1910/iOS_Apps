//
//  Current.swift
//  Stromy
//
//  Created by Ankit on 19/03/16.
//  Copyright © 2016 vinsol. All rights reserved.
//

import UIKit


struct Current {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        
        self.temperature = currentWeather["temperature"] as! Int
        self.humidity = currentWeather["humidity"] as! Double
        self.precipProbability = currentWeather["precipProbability"] as! Double
        self.summary = currentWeather["summary"] as! String

        let currentTimeIntValue = currentWeather["time"] as! Int
        self.currentTime = dateStringFromUnixTime(currentTimeIntValue)

        let stringIcon = currentWeather["icon"] as! String
        self.icon = weatherIconFromString(stringIcon)
        
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
            case "clear-day":
                imageName = "clear-day"
            case "clear-night":
                imageName = "clear-night"
            case "rain":
                imageName = "rain"
            case "snow":
                imageName = "snow"
            case "wind":
                imageName = "wind"
            case "fog":
                imageName = "fog"
            case "cloudy":
                imageName = "cloudy"
            case "partly-cloudy-day":
                imageName = "partly-cloudy"
            case "partly-cloudy-night":
                imageName = "cloudy-night"
            default:
                imageName = "default"
        }
        
        return UIImage(named: imageName)!
    }
}
