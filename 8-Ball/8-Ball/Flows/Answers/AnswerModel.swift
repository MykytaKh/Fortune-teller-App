//
//  AnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.11.2021.
//

import Foundation
import RxSwift
import RxRelay

class AnswerModel {

    private let answerManager: AnswerManager
    private let userDefaultAnswerModel: UserDefaultAnswerModel
    private let answersHistoryModel: AnswersHistoryModel
    private let dbService: DBService
    private let addedSubject = PublishRelay<String>()
    private let disposeBag = DisposeBag()

    init(userDefaultAnswerModel: UserDefaultAnswerModel,
         answerManager: AnswerManager, answersHistoryModel: AnswersHistoryModel, dbService: DBService) {

        self.answersHistoryModel = answersHistoryModel
        self.userDefaultAnswerModel = userDefaultAnswerModel
        self.answerManager = answerManager
        self.dbService = dbService

        setupSubscribings()
    }

    func setupSubscribings() {

        addedSubject.subscribe { event in
            self.dbService.addAnswer(answerName: event)
        }
        .disposed(by: disposeBag)
    }

    func fetchNewValue() -> Observable<String> {

        answerManager.fetchAnswer(defaultAnswer: fetchDefaultAnswer())
    }

    func fetchDefaultAnswer() -> String {

        if let userAnswer = self.userDefaultAnswerModel.answerValue {
            return userAnswer
        } else {
            self.answersHistoryModel.fetchRandomValue { value in
                if let value = value {
                    value
                }
            }
        }

        return L10n.Cancel.Error.NoAnswers.title
    }

    func addAnswer(answer: String) {

        addedSubject.accept(answer)
    }
}
