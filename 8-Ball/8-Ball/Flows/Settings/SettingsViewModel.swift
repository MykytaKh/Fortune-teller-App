//
//  SettingsViewModel.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 17.11.2021.
//

import Foundation

class SettingsViewModel {
    
    private let settingsModel: SettingsModel
    
    init(settingsModel: SettingsModel) {
        self.settingsModel = settingsModel
    }
    
    func getUserAnswers() -> [Answer] {
        Array(settingsModel.getUserAnswers()).sorted(by: >)
    }
    
    func saveUserAnswer(_ answer: String) {
        var answers = settingsModel.getUserAnswers()
        let answer = Answer(value: answer, date: Date())
        answers.insert(answer)
        settingsModel.saveUserAnswers(answers)
    }
    
    func deleteUserAnswer(_ answer: Answer) {
        settingsModel.deleteUserAnswer(answer)
    }
    
}
