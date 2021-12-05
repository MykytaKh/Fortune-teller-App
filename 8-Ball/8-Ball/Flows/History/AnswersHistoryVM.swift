//
//  AnswersHistoryVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation

class AnswersHistoryVM {

    private let answersHistoryModel: AnswersHistoryModel

    init(answersHistoryModel: AnswersHistoryModel) {
        self.answersHistoryModel = answersHistoryModel
    }

    func fetchAnswers(completion: @escaping ([HistoryAnswerModel]) -> Void) {
        answersHistoryModel.fetchAnswers { answers in
            completion(answers)
        }
    }

    func deleteAnswer(_ answer: HistoryAnswerModel) {
        answersHistoryModel.deleteAnswer(answer)
    }
}
