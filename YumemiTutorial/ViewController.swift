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
        enum WeatherEnum: String {
            case sunny = "sunny"
            case cloudy = "cloudy"
            case rain = "rainy"
        }
        let condition: WeatherEnum
        let imageColor: UIColor
        
        init(weatherString: String) {
            self.condition = WeatherEnum(rawValue: weatherString)!
            if self.condition == .sunny {
                self.imageColor = .red
            } else if self.condition == .cloudy {
                self.imageColor = .gray
            } else {
                self.imageColor = .blue
            }
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

