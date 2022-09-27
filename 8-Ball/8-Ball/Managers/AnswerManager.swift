//
//  AnswerManager.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 09.11.2021.
//

import Foundation
import RxSwift

protocol AnswerManagerProtocol {
    func fetchAnswer() -> Observable<String>
}

class AnswerManager: AnswerManagerProtocol {

    private let networkService: NetworkServiceProtocol
    private let randomAnswerGenerator: RandomAnswerGeneratorProtocol

    init(networkService: NetworkServiceProtocol, randomAnswerGenerator: RandomAnswerGeneratorProtocol) {
        self.networkService = networkService
        self.randomAnswerGenerator = randomAnswerGenerator
    }

    func fetchAnswer() -> Observable<String> {
        networkService.fetchResponse(defaultAnswer: getDefaultAnswer())
    }
    
    private func getDefaultAnswer() -> String {
        randomAnswerGenerator.getRandomAnswer()
    }
}
