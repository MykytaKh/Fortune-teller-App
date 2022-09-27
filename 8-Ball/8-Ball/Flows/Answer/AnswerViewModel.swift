//
//  AnswerViewModel.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 16.11.2021.
//

import Foundation
import RxSwift

class AnswerViewModel {

    private let answerModel: AnswerModel

    init(answerModel: AnswerModel) {
        self.answerModel = answerModel
    }

    func getNewAnswer() -> Observable<String> {
        answerModel.getNewAnswer().map { $0.uppercased() }
    }

    func addAnswer(_ answer: String) {
        answerModel.addAnswer(answer)
    }
    
}
