//
//  ManagedAnswer.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 29.11.2021.
//

import Foundation
import RealmSwift

protocol ManagedAnswerProtocol {
    var name: String { get set }
    var date: Date { get set }
}

class ManagedAnswer: Object, ManagedAnswerProtocol {

    @objc dynamic var name: String = ""
    @objc dynamic var date: Date = Date()
    
}
