//
//  HistoryCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 20.12.2021.
//

import Foundation
import UIKit

class HistoryCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?

    override init(parent: NavigationNode?) {
        super.init(parent: parent)

        addHandlers()
    }

    private func addHandlers() {

        let model = AnswersHistoryModel(dbService: DBService())
        let viewModel = AnswersHistoryVM(answersHistoryModel: model)
        let controller = AnswersHistoryVC(answersHistoryVM: viewModel)

        containerViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func createFlow() -> UIViewController {

        let model = AnswersHistoryModel(dbService: DBService())
        let viewModel = AnswersHistoryVM(answersHistoryModel: model)
        let controller = AnswersHistoryVC(answersHistoryVM: viewModel)

        return controller
    }
}
