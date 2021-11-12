//
//  AnswerManager.swift
//  8-Ball
//
//  Created by Никита Хламов on 09.11.2021.
//

import Foundation
import UIKit

protocol AnswerManagerProtocol {
    func fetchAnswer(success: @escaping (String) -> (), failure: @escaping () -> ())
}

class AnswerManager: AnswerManagerProtocol {
    
    private let defaultAnswers = ["It is certain",
                                  "It is decidedly so",
                                  "Without a doubt",
                                  "Yes, definitely",
                                  "You may rely on it",
                                  "As I see it, yes",
                                  "Most likely",
                                  "Outlook good",
                                  "Yes",
                                  "Signs point to yes",
                                  "Reply hazy try again",
                                  "Ask again later",
                                  "Better not tell you now",
                                  "Cannot predict now",
                                  "Concentrate and ask again",
                                  "Don't count on it",
                                  "My reply is no",
                                  "My sources say no",
                                  "Outlook not so good",
                                  "Very doubtful"]
    private var userAnswers = [String]()
    private let networkService: NetworkProtocol
    private let dbService: DBServiceProtocol
    
    init(networkService: NetworkProtocol = Network(), dbService: DBServiceProtocol = DBService()) {
        self.networkService = networkService
        self.dbService = dbService
    }
    
    func fetchAnswer(success: @escaping (String) -> (), failure: @escaping () -> ()) {
        networkService.fetchResponse { answer in
            success(answer)
        } failure: { [weak self]  in
            if let userAnswer = self?.dbService.getUserAnswers().randomElement() {
                success(userAnswer)
            } else if let defaultAnswer = self?.defaultAnswers.randomElement() {
                success(defaultAnswer)
            } else {
                failure()
            }
        }
    }
}
