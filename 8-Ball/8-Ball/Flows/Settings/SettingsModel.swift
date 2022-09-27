//
//  SettingsModel.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 16.11.2021.
//

import Foundation

class SettingsModel {
    
    private let uaService: UserAnswersServiceProtocol
    
    init(uaService: UserAnswersServiceProtocol) {
        self.uaService = uaService
    }
    
    func getUserAnswers() -> Set<Answer> {
        uaService.getUserAnswers()
    }
    
    private func setUserAnswers(_ answers: Set<Answer>) {
        uaService.setUserAnswers(answers)
    }
    
    func saveUserAnswers(_ answers: Set<Answer>) {
        setUserAnswers(answers)
    }
    
    func deleteUserAnswer(_ answer: Answer) {
        var answers = getUserAnswers()
        answers.remove(answer)
        setUserAnswers(answers)
    }
    
}
