//
//  SettingsCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 20.12.2021.
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

        let model = SettingsModel()
        let viewModel = SettingsVM(settingsModel: model)
        let controller = SettingsVC(settingsVM: viewModel)

        containerViewController?.navigationController?.pushViewController(controller, animated: true)
    }

    func createFlow() -> UIViewController {

        let model = SettingsModel()
        let viewModel = SettingsVM(settingsModel: model)
        let controller = SettingsVC(settingsVM: viewModel)

        return controller
    }
}
