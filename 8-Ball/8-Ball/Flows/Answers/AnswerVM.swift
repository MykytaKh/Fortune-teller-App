//
//  DefaultAnswerVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation
import RxSwift

class AnswerVM {

    private let answerModel: AnswerModel

    init(answerModel: AnswerModel) {
        self.answerModel = answerModel
    }

    func getValue() -> Observable<String> {
        answerModel.fetchNewValue().map { $0.uppercased() }
    }

    func addAnswer(answer: String) {
        answerModel.addAnswer(answer: answer)
    }
}
