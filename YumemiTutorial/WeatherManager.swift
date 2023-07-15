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
            struct WeatherRequestData: Encodable {
                var area: String
                var date: String
            }
            
            struct WeatherData: Decodable {
                var max_temperature: Int
                var date: String
                var min_temperature: Int
                var weather_condition: String
                var region: String = ""
                
                private enum CodingKeys: String, CodingKey {
                    case max_temperature, date, min_temperature, weather_condition
                }
            }
            
            let date = Date()
            let format = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let locale = Locale(identifier: "ja_JP")
            let dateString = DateUtils.stringFromDate(date: date, format: format, locale: locale)

            let requestData = WeatherRequestData(area: regionString, date: dateString)
            guard let jsonString: String = JSONUtils.jsonFromObject(object: requestData) else { throw YumemiWeatherError.invalidParameterError }
            
            let responseData = try YumemiWeather.fetchWeather(jsonString)
            guard var weatherData = JSONUtils.objectFromJson(mold: WeatherData.self, json: responseData) else {
                throw YumemiWeatherError.invalidParameterError
            }
            weatherData.region = regionString
            
            let weather = Weather.init(weatherCondition: weatherData.weather_condition, region: weatherData.region, dateString: weatherData.date, max_temperature: weatherData.max_temperature, min_temperature: weatherData.min_temperature)
            
            delegate?.weatherManager(self, didUpdatedWeather: weather)
        } catch YumemiWeatherError.invalidParameterError {
            delegate?.weatherManager(self, didFailWithError: YumemiWeatherError.invalidParameterError)
        } catch {
            delegate?.weatherManager(self, didFailWithError: YumemiWeatherError.unknownError)
        }
    }
}
