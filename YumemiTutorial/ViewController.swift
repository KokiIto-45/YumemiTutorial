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
    private var alertController: UIAlertController!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(foreground(notification:)),
                                                name: UIApplication.willEnterForegroundNotification,
                                                object: nil
        )
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(background(notification:)),
                                                name: UIApplication.didEnterBackgroundNotification,
                                                object: nil
        )
        weatherManager.delegate = self
        weatherManager.requestFetchingWeatherViaApi(validRegionString)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    deinit{
        print("ViewControllerインスタンスが破棄されます")
    }
    
    private func setWeatherInfos(weather: Weather) {
        let name = weather.condition.rawValue
        let color = weather.imageColor
        weatherImageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
        minTemperatureLabel.text = String(weather.min_temperature)
        maxTemperatureLabel.text = String(weather.max_temperature)
    }
    
    // MARK: Notifications
    @objc func foreground(notification: Notification) {
        weatherManager.requestFetchingWeatherViaApi(validRegionString)
    }
    
    @objc func background(notification: Notification) {
        alertController.dismiss(animated: true)
    }
 
    // MARK: Actions
    @IBAction func tapReloadButton(_ sender: Any) {
        weatherManager.requestFetchingWeatherViaApi(validRegionString)
    }
}

extension ViewController: WeatherManagerDelegate {
    func weatherManager(_ manager: WeatherManager, didUpdatedWeather weather: Weather) {
        setWeatherInfos(weather: weather)
    }
    func weatherManager(_ manager: WeatherManager, didFailWithError error: Error) {
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

