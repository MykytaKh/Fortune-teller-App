//
//  DefaultAnswerVM.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation

enum AnswerType {
    case user, local
}

class DefaultAnswerVM {
    private let answerType: AnswerType
    private let answerValue: String?
    init (answerType: AnswerType) {
        self.answerType = answerType
        switch(answerType) {
        case .user:
            self.answerValue = UserDefaultAnswerModel().answerValue
        case.local:
            self.answerValue = LocalDefaultAnswerModel().answerValue
        }
    }
    func getValue() -> String? {
        return self.answerValue?.uppercased()
    }
}
