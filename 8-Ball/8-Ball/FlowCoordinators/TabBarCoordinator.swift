//
//  FlowCoordinator.swift
//  8-Ball
//
//  Created by Никита Хламов on 17.12.2021.
//

import Foundation
import UIKit
import RAMAnimatedTabBarController

enum OrdersEvent: NavigationEvent {

    case answer
    case settings
    case history

}

class TabBarCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?

    override init(parent: NavigationNode?) {
        super.init(parent: parent)

        addHandlers()
    }

    private func addHandlers() {

        addHandler { [weak self] (event: OrdersEvent) in
            guard let self = self else { return }

            switch event {
            case .answer:
                self.presentAnswer()

            case .settings:
                self.presentSettings()

            case .history:
                self.presentHistory()
            }
        }
    }

    private func presentAnswer() {

        let coordinator = AnswersCoordinator(parent: self)
        let controller = coordinator.createFlow()

        containerViewController?.navigationController?.pushViewController(controller, animated: true)
    }

    private func presentSettings() {

        let coordinator = SettingsCoordinator(parent: self)
        let controller = coordinator.createFlow()

        containerViewController?.navigationController?.pushViewController(controller, animated: true)
    }

    private func presentHistory() {

        let coordinator = HistoryCoordinator(parent: self)
        let controller = coordinator.createFlow()

        containerViewController?.navigationController?.pushViewController(controller, animated: true)
    }

    func createFlow() -> UIViewController {

        let customTabBar = RAMAnimatedTabBarController()

        let answerCoordinator = AnswersCoordinator(parent: self)
        let answerVC = answerCoordinator.createFlow()

        let settingsCoordinator = SettingsCoordinator(parent: self)
        let settingsVC = settingsCoordinator.createFlow()

        let historyCoordinator = HistoryCoordinator(parent: self)
        let historyVC = historyCoordinator.createFlow()

        answerVC.tabBarItem = RAMAnimatedTabBarItem(title: L10n.Answer.title,
                                                   image: UIImage(systemName: L10n.Ball.image), tag: 1)
        (answerVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        settingsVC.tabBarItem = RAMAnimatedTabBarItem(title: L10n.Settings.title,
                                                  image: UIImage(systemName: L10n.Settings.image), tag: 2)
        (settingsVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        historyVC.tabBarItem = RAMAnimatedTabBarItem(title: L10n.AnswersHistory.title,
                                                     image: UIImage(systemName: L10n.History.image), tag: 3)
        (historyVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        customTabBar.setViewControllers([answerVC, settingsVC, historyVC], animated: false)

        return customTabBar
    }
}
