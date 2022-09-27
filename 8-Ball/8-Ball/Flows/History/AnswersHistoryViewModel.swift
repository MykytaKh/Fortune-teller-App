//
//  AnswersHistoryViewModel.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 26.11.2021.
//

import Foundation

class AnswersHistoryViewModel {
    
    private let answersHistoryModel: AnswersHistoryModel
    
    init(answersHistoryModel: AnswersHistoryModel) {
        self.answersHistoryModel = answersHistoryModel
    }
    
    func fetchAnswers(completion: @escaping ([Answer]) -> Void) {
        answersHistoryModel.fetchAnswers { answers in
            var editedAnswers: [Answer] = []
            for answer in answers {
                let editedAnswer = Answer(value: answer.name, date: answer.date)
                editedAnswers.append(editedAnswer)
            }
            completion(editedAnswers)
        }
    }
    
    func deleteAnswer(_ answer: Answer) {
        let managedAnswer = ManagedAnswer()
        managedAnswer.name = answer.value
        managedAnswer.date = answer.date
        answersHistoryModel.deleteAnswer(managedAnswer)
    }
    
}
