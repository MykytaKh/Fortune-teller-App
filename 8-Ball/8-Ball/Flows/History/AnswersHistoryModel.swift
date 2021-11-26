//
//  AnswersHistoryModel.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import RealmSwift

class AnswersHistoryModel {
    var answers: Results<RealmService>!
    var answerValue: String? {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(RealmService.self)
            let randomObject = realmObjects.randomElement()
            let randomObjectName = randomObject?.name
            return randomObjectName
        } catch {
            print(L10n.Realm.error)
            return nil
        }
    }

    func getAnswers() -> Results<RealmService>! {
        do {
            let realm = try Realm()
            let answers = realm.objects(RealmService.self).sorted(byKeyPath: "date", ascending: false)
            return answers
        } catch {
            print("Error")
        }
        return answers
    }
    func addAnswer(answer: String) {
        let answers = RealmService()
        answers.name = answer
        answers.date = Date()
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(answers)
            }
        } catch {
            print("Error")
        }
    }
}
