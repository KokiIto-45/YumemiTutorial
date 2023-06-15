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
    func weatherManager(_ manager: WeatherManager, didFailWithError error: Error)
}

class WeatherManager {
    weak var delegate: WeatherManagerDelegate?
    
    func requestFetchingWeatherViaApi(_ regionString: String) {
        do {
            let weatherString = try YumemiWeather.fetchWeatherCondition(at: regionString)
            let weather = Weather.init(weatherString: weatherString)
            delegate?.weatherManager(self, didUpdatedWeather: weather)
        } catch YumemiWeatherError.invalidParameterError {
            delegate?.weatherManager(self, didFailWithError: YumemiWeatherError.invalidParameterError)
        } catch {
            delegate?.weatherManager(self, didFailWithError: YumemiWeatherError.unknownError)
        }
    }
}
