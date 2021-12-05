//
//  UserDefaultAnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 16.11.2021.
//

import Foundation

class UserDefaultAnswerModel {

    private let udService: UDService
    var answerValue: String? {
        return udService.getUserAnswers().randomElement()
    }

    init(udService: UDService) {
        self.udService = udService
    }
}
