//
//  ModelAnswer.swift
//  8-Ball
//
//  Created by Никита Хламов on 14.11.2021.
//

import Foundation

class LocalDefaultAnswerModel {
    private let localAnswers = ["It is certain",
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
    var answerValue: String? {
        return localAnswers.randomElement()
    }
}
