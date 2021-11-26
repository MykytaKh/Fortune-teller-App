//
//  RealmService.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import RealmSwift

class RealmService: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    }
