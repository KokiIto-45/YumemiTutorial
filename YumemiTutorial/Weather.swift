//
//  Weather.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/12.
//

import UIKit
import Foundation
import YumemiWeather

class Weather {
    enum WeatherEnum: String, CaseIterable {
        case sunny
        case cloudy
        case rainy
        
        func getColor() -> UIColor {
            switch self {
            case .sunny: return .red
            case .cloudy: return .gray
            case .rainy: return .blue
            }
        }
    }
    
    let condition: WeatherEnum
    let imageColor: UIColor
    let region: String
    let date: Date
    let max_temperature: Int
    let min_temperature: Int
    
    init(weatherCondition: String, region: String, dateString: String, max_temperature: Int, min_temperature: Int) {
        self.condition = WeatherEnum(rawValue: weatherCondition)!
        self.imageColor = self.condition.getColor()
        self.region = region
        
        let format = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let locale = Locale(identifier: "ja_JP")
        let date = DateUtils.dateFromString(string: dateString, format: format, locale: locale)
        self.date = date
        
        self.max_temperature = max_temperature
        self.min_temperature = min_temperature
    }
}
