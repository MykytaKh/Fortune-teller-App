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

    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func fetchAnswer(success: @escaping (String) -> Void, failure: @escaping () -> Void) {
        networkService.fetchResponse { answer in
            success(answer)
        } failure: {
            failure()
        }
    }
}
