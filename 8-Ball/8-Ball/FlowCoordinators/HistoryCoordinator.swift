//
//  HistoryCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 20.12.2021.
//

import Foundation
import UIKit

class HistoryCoordinator {

    let containerViewController: UIViewController
    private let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        containerViewController = AnswersHistoryVC(answersHistoryVM: AnswersHistoryVM(answersHistoryModel: AnswersHistoryModel(dbService: DBService())))
    }

    func start() {
        navigationController?.pushViewController(containerViewController, animated: true)
    }
}
