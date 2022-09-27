//
//  Answer.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 05.12.2021.
//

import Foundation

struct Answer: Hashable, Codable, Comparable {

    let value: String
    let date: Date
    let formattedDate: String
    
    init(value: String, date: Date) {
        self.value = value
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.formattedDate = dateFormatter.string(from: date)
    }
    
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        lhs.date == rhs.date
    }
    
    static func < (lhs: Answer, rhs: Answer) -> Bool {
        lhs.date < rhs.date
    }
    
}
