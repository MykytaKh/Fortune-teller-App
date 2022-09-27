//
//  SettingsCoordinator.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 20.12.2021.
//

import Foundation
import UIKit

class SettingsCoordinator: NavigationNode, FlowCoordinator {

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
        let model = SettingsModel(uaService: uaService)
        let viewModel = SettingsViewModel(settingsModel: model)
        let viewController = SettingsViewController(settingsViewModel: viewModel)
        return viewController
    }
    
}
