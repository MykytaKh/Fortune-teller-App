//
//  AnswersCoordinator.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 20.12.2021.
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
        containerViewController?.navigationController?.pushViewController(createFlow(), animated: true)
    }
    
    func createFlow() -> UIViewController {
        let uaService: UserAnswersServiceProtocol = UserDefaultsService()
        let dbService: DataBaseServiceProtocol = RealmService()
        let networkService: NetworkServiceProtocol = NetworkService()
        let randomAnswerGenerator: RandomAnswerGeneratorProtocol = RandomAnswerGenerator(uaService: uaService, dbService: dbService)
        let answerManager: AnswerManagerProtocol = AnswerManager(networkService: networkService, randomAnswerGenerator: randomAnswerGenerator)
        let model = AnswerModel(answerManager: answerManager, dbService: dbService)
        let viewModel = AnswerViewModel(answerModel: model)
        let viewController = AnswerViewController(answerViewModel: viewModel)
        return viewController
    }
    
}
