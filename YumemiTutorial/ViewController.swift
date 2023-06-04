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
    
    private var weather:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setWeatherImage()
    }
    
    private func setWeatherImage() {
        weather = YumemiWeather.fetchWeatherCondition()
        let name:String = weather
        var color:UIColor
        if weather == "sunny" {
            color = .red
        } else if weather == "cloudy" {
            color = .gray
        } else {
            color = .blue
        }
        weatherImageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = color
    }
 
    // Actions
    @IBAction func tapReloadButton(_ sender: Any) {
        setWeatherImage()
    }
    


}

