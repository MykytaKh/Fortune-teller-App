//
//  AnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.11.2021.
//

import Foundation

enum AnswerType {
    case user, local
}

class AnswerModel {
    func fetchNewValue(onFinish: @escaping (String) -> Void) {
    AnswerManager(networkService: Network()).fetchAnswer { answer in
            onFinish(answer)
        } failure: { [weak self] in
            if let userAnswer = self?.getDefaultAnswer(answerType: .user) {
                onFinish(userAnswer)
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
            return UserDefaultAnswerModel().answerValue
        case.local:
            return LocalDefaultAnswerModel().answerValue
        }
    }
}
