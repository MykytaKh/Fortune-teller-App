//
//  DBService.swift
//  8-Ball
//
//  Created by Никита Хламов on 09.11.2021.
//

import Foundation

protocol UDServiceProtocol {
    func saveUserAnswers(array: [String])
    func getUserAnswers() -> [String]
}

class UDService: UDServiceProtocol {

    private let keyToAnswers = "keyToAnswers"

    func saveUserAnswers(array: [String]) {
        UserDefaults.standard.set(array, forKey: keyToAnswers)
    }

    func getUserAnswers() -> [String] {
        if let answers = UserDefaults.standard.array(forKey: keyToAnswers) as? [String] {
            return answers
        }
        return [String]()
    }
}
