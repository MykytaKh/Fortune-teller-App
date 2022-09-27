//
//  AppNavigator.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 22.12.2021.
//

import Foundation
import UIKit

protocol FlowCoordinator {
    var containerViewController: UIViewController? { get set }

    func createFlow() -> UIViewController
}

final class AppNavigator: NavigationNode {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(parent: nil)
    }

    func startFlow() {
        let coordinator = TabBarCoordinator(parent: self)
        let controller = coordinator.createFlow()

        window.rootViewController = controller

        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }

        window.makeKeyAndVisible()
    }
    
}
