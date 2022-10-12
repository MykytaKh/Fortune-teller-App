//
//  RandomAnswerGenerator.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 16.11.2021.
//

import Foundation
import RealmSwift

protocol RandomAnswerGeneratorProtocol {
    func getRandomAnswer() -> String
}

class RandomAnswerGenerator: RandomAnswerGeneratorProtocol {
    
    private let uaService: UserAnswersServiceProtocol
    private let dbService: DataBaseServiceProtocol
    private var dbAnswers: [Answer]?
    private var notificationToken: NotificationToken?
    
    init(uaService: UserAnswersServiceProtocol, dbService: DataBaseServiceProtocol) {
        self.uaService = uaService
        self.dbService = dbService
        fetchAnswersFromDB()
        prepareNotification()
    }
    
    func getRandomAnswer() -> String {
        if let userAnswer = uaService.getUserAnswers().randomElement()?.value {
            return userAnswer
        } else if let dbAnswer = dbAnswers?.randomElement()?.value {
            return dbAnswer
        }
        return L10n.NoAnswers.title
    }
    
    private func fetchAnswersFromDB() {
        dbService.fetchAnswers { [weak self] answers in
            var editedAnswers: [Answer] = []
            for answer in answers {
                let editedAnswer = Answer(value: answer.name, date: answer.date)
                editedAnswers.append(editedAnswer)
            }
            self?.dbAnswers = editedAnswers
        }
    }
    
    private func prepareNotification() {
        let realm = try? Realm()
        let results = realm?.objects(ManagedAnswer.self)
        notificationToken = results?.observe { [weak self] _ in
            self?.fetchAnswersFromDB()
        }
    }
    
}
