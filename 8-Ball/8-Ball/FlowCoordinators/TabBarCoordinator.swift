//
//  FlowCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.12.2021.
//

import Foundation
import UIKit

class TabBarCoordinator {

    let containerViewController: UIViewController
    private let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        containerViewController = CustomTabBarController()
    }

    func start() {
        navigationController?.pushViewController(containerViewController, animated: true)
    }
}
