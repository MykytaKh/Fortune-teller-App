//
//  RealmService.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import RealmSwift

class DBService {

    func addAnswer(answerName: String) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let newAnswer = ManagedAnswer()
                do {
                    let realm = try Realm()
                    newAnswer.name = answerName
                    try realm.write {
                        realm.add(newAnswer)
                        realm.refresh()
                    }
                } catch {
                    print("Error")
                }
            }
        }
    }

    func deleteAnswer(_ answer: ManagedAnswer) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let object = realm.objects(ManagedAnswer.self).where {
                        $0.name == answer.name && $0.date == answer.date
                    }.first
                    if let object = object {
                        try realm.write({
                            realm.delete(object)
                            realm.refresh()
                            return
                        })
                    }
                } catch {
                    print("Error")
                }
            }
        }
    }

    func fetchAnswers(completion: @escaping ([ManagedAnswer]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let realmObjects = realm.objects(ManagedAnswer.self).sorted(byKeyPath: "date", ascending: false)
                    let arrayAnswers = Array(realmObjects)
                    completion(arrayAnswers)
                } catch {
                    print("Error")
                    completion([ManagedAnswer]())
                }
            }
        }
    }
}
