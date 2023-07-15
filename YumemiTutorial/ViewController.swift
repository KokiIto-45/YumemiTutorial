//
//  ViewController.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/03.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    let weatherManager = WeatherManager()
    let validRegionString = "tokyo"
    
    @IBOutlet weak var weatherImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        weatherManager.requestFetchingWeatherViaApi(validRegionString)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    deinit{
        print("ViewControllerインスタンスが破棄されます")
    }
    
    private func setWeatherImage(weather: Weather) {
        let name = weather.condition.rawValue
        let color = weather.imageColor
        weatherImageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
    }
 
    // Actions
    @IBAction func tapReloadButton(_ sender: Any) {
        weatherManager.requestFetchingWeatherViaApi(validRegionString)
    }
}

extension ViewController: WeatherManagerDelegate {
    func weatherManager(_ manager: WeatherManager, didUpdatedWeather weather: Weather) {
        setWeatherImage(weather: weather)
    }
    func weatherManager(_ manager: WeatherManager, didFailWithError error: Error) {
        var alertController: UIAlertController
        switch(error) {
        case YumemiWeatherError.invalidParameterError :
            alertController = UIAlertController(title: "無効なパラメーターです", message: "", preferredStyle: .alert)
        default:
            alertController = UIAlertController(title: "不明なエラーです", message: "", preferredStyle: .alert)
        }
        let actionChoice = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(actionChoice)
        present(alertController, animated: true, completion: nil)
    }
}

