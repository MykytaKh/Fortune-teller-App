//
//  HistoryAnswerModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 05.12.2021.
//

import Foundation

class HistoryAnswerModel {

    let value: String
    let date: Date
    let formattedDate: String

    init(value: String, date: Date) {
        self.value = value
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        self.formattedDate = dateFormatter.string(from: date)
    }
}
