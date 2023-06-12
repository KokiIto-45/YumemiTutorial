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
    
    init(weatherString: String) {
        self.condition = WeatherEnum(rawValue: weatherString)!
        self.imageColor = self.condition.getColor()
    }
}
