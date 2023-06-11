//
//  ViewController.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/03.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    class Weather {
        enum WeatherEnum: String, CaseIterable {
            case sunny
            case cloudy
            case rainy
        }
        static let weatherColorArray:[UIColor] = [.red, .gray, .blue]
        let condition: WeatherEnum
        let imageColor: UIColor
        
        init(weatherString: String) {
            self.condition = WeatherEnum(rawValue: weatherString)!
            let index: Int = WeatherEnum.allCases.firstIndex(of: self.condition)!
            self.imageColor = Weather.weatherColorArray[index]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let weather = getWeatherConditionViaAPI() else { return }
        setWeatherImage(weather: weather)
    }
    
    private func getWeatherConditionViaAPI() -> Weather? {
        let weatherString = YumemiWeather.fetchWeatherCondition()
        let weather = Weather(weatherString: weatherString)
        return weather
    }
    
    private func setWeatherImage(weather: Weather) {
        let name = weather.condition.rawValue
        let color = weather.imageColor
        weatherImageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
    }
 
    // Actions
    @IBAction func tapReloadButton(_ sender: Any) {
        guard let weather = getWeatherConditionViaAPI() else { return }
        setWeatherImage(weather: weather)
    }
    


}

