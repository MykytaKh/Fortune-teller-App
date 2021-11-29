//
//  SceneDelegate.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let dBService = DBService()
        let dataBaseService = DataBaseService()
        let userDefaultAnswerModel = UserDefaultAnswerModel(dbService: dBService)
        let answerManager = AnswerManager()
        let answersHistoryModel = AnswersHistoryModel(dataBaseService: dataBaseService)
        let answerModel = AnswerModel(userDefaultAnswerModel: userDefaultAnswerModel,
                                      answerManager: answerManager,
                                      answersHistoryModel: answersHistoryModel, dataBaseService: dataBaseService)
        let answerVM = AnswerVM(answerModel: answerModel)
        let settingsVM = SettingsVM()
        let answersHistoryVM = AnswersHistoryVM(answersHistoryModel: answersHistoryModel)
        let answersHistoryVC = AnswersHistoryVC(answersHistoryVM: answersHistoryVM)
        let settingsVC = SettingsVC(settingsVM: settingsVM)
        let answerVC = AnswerViewController(answerVM: answerVM)
        let tabBarController = UITabBarController()
        let navigationHistory = UINavigationController(rootViewController: answersHistoryVC)
        let navigationSettings = UINavigationController(rootViewController: settingsVC)
        answerVC.title = L10n.Answer.title
        navigationSettings.title = L10n.Settings.title
        navigationHistory.title = L10n.AnswersHistory.title
        tabBarController.setViewControllers([answerVC, navigationSettings, navigationHistory], animated: false)
        guard let items = tabBarController.tabBar.items else {
            return
        }
        let images = [L10n.Ball.image, L10n.Settings.image, L10n.History.image]
        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
        }
        tabBarController.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: tabBarController)
        window.rootViewController = navigation
        self.window = window
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        window.makeKeyAndVisible()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded
        // (see `application:didDiscardSceneSessions` instead).
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
