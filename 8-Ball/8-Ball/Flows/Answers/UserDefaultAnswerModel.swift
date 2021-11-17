//
//  UserDefaultAnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation

class UserDefaultAnswerModel {
     var answerValue: String? {
        return DBService().getUserAnswers().randomElement()
    }
}
