//
//  WeatherManager.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/12.
//

import Foundation
import YumemiWeather

protocol WeatherManagerDelegate: AnyObject {
    func weatherManager(_ manager: WeatherManager, didUpdatedWeather weather: Weather)
}

class WeatherManager {
    weak var delegate: WeatherManagerDelegate?
    
    func requestFetchingWeatherViaApi() {
        let weatherString = YumemiWeather.fetchWeatherCondition()
        let weather = Weather.init(weatherString: weatherString)
        delegate?.weatherManager(self, didUpdatedWeather: weather)
    }
}
