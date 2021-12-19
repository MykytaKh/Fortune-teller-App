//
//  AnswersCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 20.12.2021.
//

import Foundation
import UIKit

class AnswersCoordinator {

    let containerViewController: UIViewController
    private let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        containerViewController = AnswerViewController(answerVM: AnswerVM(answerModel:
                                                                            AnswerModel(userDefaultAnswerModel: UserDefaultAnswerModel(udService: UDService()), answerManager:
                                                                                            AnswerManager(), answersHistoryModel: AnswersHistoryModel(dbService: DBService()), dbService: DBService())))
    }

    func start() {
        navigationController?.pushViewController(containerViewController, animated: true)
    }
}
