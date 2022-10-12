//
//  RealmService.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 26.11.2021.
//

import Foundation
import RealmSwift

protocol DataBaseServiceProtocol {
    func addAnswer(_ answerValue: String)
    func deleteAnswer(_ answer: ManagedAnswerProtocol)
    func fetchAnswers(completion: @escaping ([ManagedAnswerProtocol]) -> Void)
}

class RealmService: DataBaseServiceProtocol {
    
    func addAnswer(_ answerValue: String) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let newAnswer = ManagedAnswer()
                do {
                    let realm = try Realm()
                    newAnswer.name = answerValue
                    try realm.write {
                        realm.add(newAnswer)
                        realm.refresh()
                    }
                } catch {
                    print(L10n.Error.DataBase.adding + "\(error)")
                }
            }
        }
    }
    
    func deleteAnswer(_ answer: ManagedAnswerProtocol) {
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
                    print(L10n.Error.DataBase.deleting + "\(error)")
                }
            }
        }
    }
    
    func fetchAnswers(completion: @escaping ([ManagedAnswerProtocol]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let realmObjects = realm.objects(ManagedAnswer.self).sorted(byKeyPath: "date", ascending: false)
                    let arrayAnswers = Array(realmObjects)
                    completion(arrayAnswers)
                } catch {
                    print(L10n.Error.DataBase.fetching + "\(error)")
                    completion([ManagedAnswerProtocol]())
                }
            }
        }
    }
    
}
