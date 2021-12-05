//
//  AnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.11.2021.
//

import Foundation

class AnswerModel {

    private let answerManager: AnswerManager
    private let userDefaultAnswerModel: UserDefaultAnswerModel
    private let answersHistoryModel: AnswersHistoryModel
    private let dbService: DBService

    init(userDefaultAnswerModel: UserDefaultAnswerModel,
         answerManager: AnswerManager, answersHistoryModel: AnswersHistoryModel, dbService: DBService) {
        self.answersHistoryModel = answersHistoryModel
        self.userDefaultAnswerModel = userDefaultAnswerModel
        self.answerManager = answerManager
        self.dbService = dbService
    }

    func fetchNewValue(onFinish: @escaping (String) -> Void) {
        answerManager.fetchAnswer { answer in
            onFinish(answer)
        } failure: { [weak self] in
            self?.fetchDefaultAnswer(onFinish: { value in
                onFinish(value)
            })
        }
    }

    func fetchDefaultAnswer(onFinish: @escaping (String) -> Void) {
        if let userAnswer = userDefaultAnswerModel.answerValue {
            onFinish(userAnswer)
        } else {
            answersHistoryModel.fetchRandomValue { value in
                if let value = value {
                    onFinish(value)
                } else {
                    onFinish(L10n.Cancel.Error.NoAnswers.title)
                }
            }
        }
    }

    func addAnswer(answer: String) {
        dbService.addAnswer(answerName: answer)
    }
}
