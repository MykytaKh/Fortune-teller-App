//
//  AnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.11.2021.
//

import Foundation

enum AnswerType {
    case user, history
}

class AnswerModel {
    private var answerManager: AnswerManager
    private var userDefaultAnswerModel: UserDefaultAnswerModel
    private var answersHistoryModel: AnswersHistoryModel
    init(userDefaultAnswerModel: UserDefaultAnswerModel,
         answerManager: AnswerManager, answersHistoryModel: AnswersHistoryModel) {
        self.answersHistoryModel = answersHistoryModel
        self.userDefaultAnswerModel = userDefaultAnswerModel
        self.answerManager = answerManager
    }
    func fetchNewValue(onFinish: @escaping (String) -> Void) {
        answerManager.fetchAnswer { answer in
            onFinish(answer)
        } failure: { [weak self] in
            if let userAnswer = self?.getDefaultAnswer(answerType: .user) {
                onFinish(userAnswer)
            } else if let historyAnswer = self?.getDefaultAnswer(answerType: .history) {
                onFinish(historyAnswer)
            } else {
                onFinish(L10n.Cancel.Error.NoAnswers.title)
            }
        }
    }
    func getDefaultAnswer(answerType: AnswerType) -> String? {
        switch(answerType) {
        case .user:
            return userDefaultAnswerModel.answerValue
        case.history:
            return answersHistoryModel.answerValue
        }
    }
}
