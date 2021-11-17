//
//  DefaultAnswerVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation



class AnswerVM {
    let answerModel = AnswerModel()
    func getValue(onFinish: @escaping (String) -> Void) {
        answerModel.fetchNewValue { answer in
            onFinish(answer.uppercased())
        }
    }
}
