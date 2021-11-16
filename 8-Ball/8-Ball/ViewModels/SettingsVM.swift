//
//  SettingVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation

class SettingsVM {
    private var dbService: DBService!
    private var answers: [String]!
    init(dbService: DBService) {
        self.dbService = dbService
        self.answers = getAnswersFromDB()
    }
    private func saveToDB(answers: [String]) {
        dbService.saveUserAnswers(array: answers)
    }
    private func getAnswersFromDB() -> [String] {
        return dbService.getUserAnswers()
    }
    func getAnswers() -> [String] {
        return answers
    }
    func setAnswers(value: [String]) {
        answers = value
        saveToDB(answers: answers)
    }
}
