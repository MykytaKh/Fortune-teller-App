//
//  ManagedAnswer.swift
//  8-Ball
//
//  Created by Никита Хламов on 29.11.2021.
//

import Foundation
import RealmSwift

class ManagedAnswer: Object {

    @objc dynamic var name: String = ""
    @objc dynamic var date: Date = Date()

//     init(name: String, date: Date = Date()) {
//        self.name = name
//        self.date = date
//    }
}
