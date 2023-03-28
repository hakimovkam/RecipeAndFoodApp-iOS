//
//  SceneDelegate.swift
//  galleyRecipe
//
//  Created by garpun on 08.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let networkService = NetworkService()
        let realmManager = RealmManager()

        ServiceLocator.shared.add(service: networkService)
        ServiceLocator.shared.add(service: realmManager)

        let builder: BuilderProtocol = Builder()
        let tabBarController = CustomTabBarController()
        let rootController = UINavigationController(rootViewController: tabBarController)
        let favoriteViewController = UIViewController()
        let timerViewController = UIViewController()
        let searchViewController = UIViewController()

        let router = Router(rootController: rootController,
                            builder: builder,
                            favoriteViewController: favoriteViewController,
                            timerViewController: timerViewController,
                            searchViewController: searchViewController,
                            tabBarController: tabBarController)
        router.setupTabBarController()
        rootController.isNavigationBarHidden = true

        window?.backgroundColor = .white
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
