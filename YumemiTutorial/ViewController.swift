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

