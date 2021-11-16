//
//  AnswerManager.swift
//  8-Ball
//
//  Created by Никита Хламов on 09.11.2021.
//

import Foundation

protocol AnswerManagerProtocol {
    func fetchAnswer(success: @escaping (String) -> Void, failure: @escaping () -> Void)
}

class AnswerManager: AnswerManagerProtocol {

    private let networkService: Network
    init(networkService: Network = Network()) {
        self.networkService = networkService
    }

    func fetchAnswer(success: @escaping (String) -> Void, failure: @escaping () -> Void) {
        networkService.fetchResponse { answer in
            success(answer.uppercased())
        } failure: {
            if let userAnswer = DefaultAnswerVM(answerType: .user).getValue() {
                success(userAnswer)
            } else if let defaultAnswer = DefaultAnswerVM(answerType: .local).getValue() {
                success(defaultAnswer)
            } else {
                failure()
            }
        }
    }
}
