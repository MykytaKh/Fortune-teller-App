//
//  SettingsVC.swift
//  8-Ball
//
//  Created by Никита Хламов on 19.10.2021.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    @IBOutlet var settingsView: SettingsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.didLoad()
    }
}
