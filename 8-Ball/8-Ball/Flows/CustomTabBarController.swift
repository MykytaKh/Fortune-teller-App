//
//  CustomTabBarController.swift
//  8-Ball
//
//  Created by Никита Хламов on 06.12.2021.
//

import Foundation
import RAMAnimatedTabBarController

class CustomTabBarController: RAMAnimatedTabBarController {

    private let answerVC: AnswerViewController
    private let settingsVC: SettingsVC
    private let answersHistoryVC: AnswersHistoryVC

    init(answerVC: AnswerViewController, settingsVC: SettingsVC, answersHistoryVC: AnswersHistoryVC) {
        self.answerVC = answerVC
        self.settingsVC = settingsVC
        self.answersHistoryVC = answersHistoryVC
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    func configureTabBar() {
        answerVC.tabBarItem = RAMAnimatedTabBarItem(title: L10n.Answer.title,
                                                    image: UIImage(systemName: L10n.Ball.image), tag: 1)
        (answerVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        settingsVC.tabBarItem = RAMAnimatedTabBarItem(title: L10n.Settings.title,
                                                      image: UIImage(systemName: L10n.Settings.image), tag: 1)
        (settingsVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        answersHistoryVC.tabBarItem = RAMAnimatedTabBarItem(title: L10n.AnswersHistory.title,
                                                            image: UIImage(systemName: L10n.History.image), tag: 1)
        (answersHistoryVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()

        setViewControllers([answerVC, settingsVC, answersHistoryVC], animated: false)
    }
}
