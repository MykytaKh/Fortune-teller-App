//
//  AnswerView.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation
import UIKit

class AnswerView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    func setLabel(text: String) {
        messageLabel.text = text
    }
}
