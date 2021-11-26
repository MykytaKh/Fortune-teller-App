//
//  UserDefaultAnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation

class UserDefaultAnswerModel {
    private var dbService: DBService
    init(dbService: DBService) {
        self.dbService = dbService
    }
    var answerValue: String? {
        return dbService.getUserAnswers().randomElement()
    }
}
