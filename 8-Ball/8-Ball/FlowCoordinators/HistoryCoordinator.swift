//
//  HistoryCoordinator.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 20.12.2021.
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
        containerViewController?.navigationController?.pushViewController(createFlow(), animated: true)
    }
    
    func createFlow() -> UIViewController {
        let dbService: DataBaseServiceProtocol = RealmService()
        let model = AnswersHistoryModel(dbService: dbService)
        let viewModel = AnswersHistoryViewModel(answersHistoryModel: model)
        let viewController = AnswersHistoryViewController(answersHistoryVM: viewModel)
        return viewController
    }
    
}
