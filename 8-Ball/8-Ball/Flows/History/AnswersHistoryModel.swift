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

    func getAnswers() -> [DataBaseService] {
        return dataBaseService.getAnswers()
    }
    func addAnswer(answer: String) {
        dataBaseService.addAnswer(answer: answer)
    }
    func deleteAnswer(index: Int) {
        dataBaseService.deleteAnswer(index: index)
    }
}
