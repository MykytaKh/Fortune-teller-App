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

    func getAnswers() -> [ManagedAnswer] {
        return answersHistoryModel.getAnswers()
    }
    func deleteAnswer(index: Int) {
        answersHistoryModel.deleteAnswer(index: index)
    }
}
