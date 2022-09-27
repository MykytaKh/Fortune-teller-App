//
//  DBService.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 09.11.2021.
//

import Foundation

protocol UserAnswersServiceProtocol {
    func getUserAnswers() -> Set<Answer>
    func setUserAnswers(_ userAnswers: Set<Answer>)
}

class UserDefaultsService: UserAnswersServiceProtocol {
    
    private let keyToAnswers = "keyToAnswers"
    
    func getUserAnswers() -> Set<Answer> {
        if let data = UserDefaults.standard.data(forKey: keyToAnswers) {
            do {
                let decoder = JSONDecoder()
                let userAnswers = try decoder.decode(Set<Answer>.self, from: data)
                return userAnswers
            } catch {
                print("Unable to decode user answers. (\(error))")
            }
        }
        return []
    }
    
    func setUserAnswers(_ userAnswers: Set<Answer>) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(userAnswers)
            UserDefaults.standard.set(data, forKey: keyToAnswers)
        } catch {
            print("Unable to encode user answers. (\(error))")
        }
    }
    
}
