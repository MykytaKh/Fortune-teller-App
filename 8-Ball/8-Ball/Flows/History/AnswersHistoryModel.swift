//
//  AnswersHistoryModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation

class AnswersHistoryModel {

    private let dbService: DBService

    init(dbService: DBService) {
        self.dbService = dbService
    }

    func fetchRandomValue(completion: @escaping (String?) -> Void) {
        fetchAnswers { answers in
            let randomAnswer = answers.randomElement()
            let randomValue = randomAnswer?.value
            completion(randomValue)
        }
    }

    func fetchAnswers(completion: @escaping ([HistoryAnswerModel]) -> Void) {
        dbService.fetchAnswers { answers in
            var historyAnswers = [HistoryAnswerModel]()
            for answer in answers {
                let historyAnswerModel = HistoryAnswerModel(value: answer.name, date: answer.date)
                historyAnswers.append(historyAnswerModel)
            }
            completion(historyAnswers)
        }
    }

    func deleteAnswer(_ answer: HistoryAnswerModel) {
        let managedAnswer = ManagedAnswer()
        managedAnswer.date = answer.date
        managedAnswer.name = answer.value
        dbService.deleteAnswer(managedAnswer)
    }
}
