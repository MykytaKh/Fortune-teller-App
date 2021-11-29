//
//  ManagedAnswer.swift
//  8-Ball
//
//  Created by Никита Хламов on 29.11.2021.
//

import Foundation
import RealmSwift

class ManagedAnswer: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
}
