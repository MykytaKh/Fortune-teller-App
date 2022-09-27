//
//  AnswersHistoryModel.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 26.11.2021.
//

import Foundation

class AnswersHistoryModel {
    
    private let dbService: DataBaseServiceProtocol
    
    init(dbService: DataBaseServiceProtocol) {
        self.dbService = dbService
    }
    
    func fetchAnswers(completion: @escaping ([ManagedAnswerProtocol]) -> Void) {
        dbService.fetchAnswers { answers in
            completion(answers)
        }
    }
    
    func deleteAnswer(_ answer: ManagedAnswerProtocol) {
        dbService.deleteAnswer(answer)
    }
    
}
