//
//  AnswersHistoryVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import RealmSwift

class AnswersHistoryVM {
    private let answersHistoryModel: AnswersHistoryModel
    init(answerHistoryModel: AnswersHistoryModel) {
        self.answersHistoryModel = answerHistoryModel
    }

    func getAnswers() -> Results<RealmService>! {
        return answersHistoryModel.getAnswers()
    }
    func addAnswer(answer: String) {
        answersHistoryModel.addAnswer(answer: answer)
    }
}
