//
//  AnswersCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 20.12.2021.
//

import Foundation
import UIKit

class AnswersCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?

    override init(parent: NavigationNode?) {
        super.init(parent: parent)

        addHandlers()
    }

    private func addHandlers() {

        let model = AnswerModel(userDefaultAnswerModel: UserDefaultAnswerModel(udService: UDService()), answerManager: AnswerManager(),
                                answersHistoryModel: AnswersHistoryModel(dbService: DBService()), dbService: DBService())
        let viewModel = AnswerVM(answerModel: model)
        let controller = AnswerViewController(answerVM: viewModel)
        containerViewController?.navigationController?.pushViewController(controller, animated: true)
    }

    func createFlow() -> UIViewController {
        let model = AnswerModel(userDefaultAnswerModel: UserDefaultAnswerModel(udService: UDService()), answerManager: AnswerManager(),
                                answersHistoryModel: AnswersHistoryModel(dbService: DBService()), dbService: DBService())
        let viewModel = AnswerVM(answerModel: model)
        let controller = AnswerViewController(answerVM: viewModel)
        return controller
    }
}
