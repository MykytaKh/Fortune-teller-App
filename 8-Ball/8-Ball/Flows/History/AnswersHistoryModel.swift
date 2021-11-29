//
//  AnswersHistoryModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation

class AnswersHistoryModel {
    private let dataBaseService: DataBaseService
    var answerValue: String? {
       return dataBaseService.getRandomAnswer()
    }
    init(dataBaseService: DataBaseService) {
        self.dataBaseService = dataBaseService
    }

    func getAnswers() -> [ManagedAnswer] {
        return dataBaseService.getAnswers()
    }
    func deleteAnswer(index: Int) {
        dataBaseService.deleteAnswer(index: index)
    }
}
