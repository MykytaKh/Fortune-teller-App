//
//  SettingsVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.11.2021.
//

import Foundation

class SettingsVM {

    private let settingsModel = SettingsModel()

    func getAnswers() -> [String] {
        return settingsModel.getAnswers()
    }

    func setAnswers(answers: [String]) {
        settingsModel.setAnswers(value: answers)
    }
}
