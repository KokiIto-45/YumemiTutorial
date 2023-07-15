//
//  DismissSegue.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/10.
//

import Foundation
import UIKit

class DismissSegue: UIStoryboardSegue {

    override func perform() {
        self.source.dismiss(animated: true, completion: nil)
    }

}
