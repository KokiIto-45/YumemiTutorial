//
//  NewViewController.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/10.
//

import UIKit

class  NewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "openWeatherViewSegue", sender: self)
    }
}

