//
//  AnswerManager.swift
//  8-Ball
//
//  Created by Никита Хламов on 09.11.2021.
//

import Foundation
import RxSwift

protocol AnswerManagerProtocol {
    func fetchAnswer() -> Observable<String>
}

class AnswerManager: AnswerManagerProtocol {

    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func fetchAnswer() -> Observable<String> {
        networkService.fetchResponse()
    }
}
