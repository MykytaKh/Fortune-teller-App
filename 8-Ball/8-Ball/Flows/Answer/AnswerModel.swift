//
//  AnswerModel.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 17.11.2021.
//

import Foundation
import RxSwift
import RxRelay

class AnswerModel {
    
    private let answerManager: AnswerManagerProtocol
    private let dbService: DataBaseServiceProtocol
    private let addedSubject = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    init(answerManager: AnswerManagerProtocol, dbService: DataBaseServiceProtocol) {
        self.answerManager = answerManager
        self.dbService = dbService
        prepareSubscribers()
    }
    
    private func prepareSubscribers() {
        addedSubject.subscribe { [weak self] event in
            self?.dbService.addAnswer(event)
        }
        .disposed(by: disposeBag)
    }
    
    func getNewAnswer() -> Observable<String> {
        answerManager.fetchAnswer()
    }
    
    func addAnswer(_ answer: String) {
        addedSubject.accept(answer)
    }
    
}
