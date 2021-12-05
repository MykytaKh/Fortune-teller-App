//
//  DefaultAnswerVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation

class AnswerVM {

    private let answerModel: AnswerModel

    init(answerModel: AnswerModel) {
        self.answerModel = answerModel
    }

    func getValue(onFinish: @escaping (String) -> Void) {
        answerModel.fetchNewValue { answer in
            onFinish(answer.uppercased())
        }
    }

    func addAnswer(answer: String) {
        answerModel.addAnswer(answer: answer)
    }
}
