//
//  AnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.11.2021.
//

import Foundation
import RealmSwift

enum AnswerType {
    case user, local, history
}

class AnswerModel {
    private var answerManager: AnswerManager
    private var localDefaultAnswerModel: LocalDefaultAnswerModel
    private var userDefaultAnswerModel: UserDefaultAnswerModel
    private var answersHistoryModel: AnswersHistoryModel
    init(userDefaultAnswerModel: UserDefaultAnswerModel, localDefaultAnswerModel: LocalDefaultAnswerModel,
         answerManager: AnswerManager, answersHistoryModel: AnswersHistoryModel) {
        self.answersHistoryModel = answersHistoryModel
        self.userDefaultAnswerModel = userDefaultAnswerModel
        self.localDefaultAnswerModel = localDefaultAnswerModel
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
            } else if let defaultAnswer = self?.getDefaultAnswer(answerType: .local) {
                onFinish(defaultAnswer)
            } else {
                onFinish(L10n.Cancel.Error.title)
            }
        }
    }
    func getDefaultAnswer(answerType: AnswerType) -> String? {
        switch(answerType) {
        case .user:
            return userDefaultAnswerModel.answerValue
        case.local:
            return localDefaultAnswerModel.answerValue
        case.history:
            return answersHistoryModel.answerValue
        }
    }
}
