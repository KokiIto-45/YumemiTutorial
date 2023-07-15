//
//  ViewController.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherManager = WeatherManager()
    
    @IBOutlet weak var weatherImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        weatherManager.requestFetchingWeatherViaApi()
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
        weatherManager.requestFetchingWeatherViaApi()
    }
}

extension ViewController: WeatherManagerDelegate {
    func weatherManager(_ manager: WeatherManager, didUpdatedWeather weather: Weather) {
        setWeatherImage(weather: weather)
    }
}

