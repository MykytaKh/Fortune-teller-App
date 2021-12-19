//
//  CustomTabBarController.swift
//  8-Ball
//
//  Created by Никита Хламов on 06.12.2021.
//

import Foundation
import RAMAnimatedTabBarController

class CustomTabBarController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    func configureTabBar() {
        let navigationController = UINavigationController()

        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        let settingsCoordRoot = settingsCoordinator.containerViewController

        let answersCoordinator = AnswersCoordinator(navigationController: navigationController)
        let answersCoordinatorRoot = answersCoordinator.containerViewController

        let historyCoordinator = HistoryCoordinator(navigationController: navigationController)
        let historyCoordinatorRoot = historyCoordinator.containerViewController

        answersCoordinatorRoot.tabBarItem = RAMAnimatedTabBarItem(title: L10n.Answer.title,
                                                                  image: UIImage(systemName: L10n.Ball.image), tag: 1)
        (answersCoordinatorRoot.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        settingsCoordRoot.tabBarItem = RAMAnimatedTabBarItem(title: L10n.Settings.title,
                                                             image: UIImage(systemName: L10n.Settings.image), tag: 2)
        (settingsCoordRoot.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        historyCoordinatorRoot.tabBarItem = RAMAnimatedTabBarItem(title: L10n.AnswersHistory.title,
                                                                  image: UIImage(systemName: L10n.History.image), tag: 3)
        (historyCoordinatorRoot.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        setViewControllers([answersCoordinatorRoot, settingsCoordRoot, historyCoordinatorRoot], animated: false)
    }
}
