//
//  Router.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol RouterMain {
    var rootController: UINavigationController? { get set }
    var favoriteViewController: UIViewController? { get set }
    var timerViewController: UIViewController? { get set }
    var searchViewController: UIViewController? { get set }
    var tabBarController: CustomTabBarController? { get set }
    var builder: BuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBarController()
    func showIngredients()
    func goBackToRootView()
    func showTimer()
}

final class Router: RouterProtocol {

    var builder: BuilderProtocol

    weak var favoriteViewController: UIViewController?
    weak var timerViewController: UIViewController?
    weak var searchViewController: UIViewController?
    weak var rootController: UINavigationController?
    weak var tabBarController: CustomTabBarController?

    private lazy var networkService: NetworkServiceProtocol = NetworkService()
    private lazy var realmManager: RealmManagerProtocol = RealmManager()

    init(rootController: UINavigationController,
         builder: BuilderProtocol,
         favoriteViewController: UIViewController,
         timerViewController: UIViewController,
         searchViewController: UIViewController,
         tabBarController: CustomTabBarController) {

        self.favoriteViewController = favoriteViewController
        self.timerViewController = timerViewController
        self.searchViewController = searchViewController
        self.rootController = rootController
        self.builder = builder
        self.tabBarController = tabBarController
    }

    func showIngredients() {
            let ingredientsViewController = builder.showIngredientsViewController(router: self, networkService: networkService)
            rootController?.pushViewController(ingredientsViewController, animated: true)
    }

    func goBackToRootView() {
        if let rootController = rootController {
            rootController.popToRootViewController(animated: true)
        }
    }

    func showTimer() {
        let timerViewController = builder.showTimerViewController(router: self, networkService: networkService)
        rootController?.pushViewController(timerViewController, animated: true)
    }

    func setupTabBarController() {
        let favoriteView = builder.createFavoriteViewController(router: self, networkService: networkService, realmManager: realmManager)
        let timerView = builder.createTimerListViewController(router: self, networkService: networkService)
        let searchView = builder.createSearchViewController(router: self, networkService: networkService, realmManager: realmManager)

        /* добавляем Item на TabBar и задаём картиночку на иконку  */
        tabBarController?.setViewControllers([generateVC(viewController: favoriteView,
                                                         image: UIImage(named: ImageConstant.savedOutline),
                                                        selectedImage: UIImage(named: ImageConstant.savedFilled)),
                                             generateVC(viewController: searchView,
                                                        image: UIImage(named: ImageConstant.recipeOutline),
                                                        selectedImage: UIImage(named: ImageConstant.recipeFilled)),
                                             generateVC(viewController: timerView,
                                                        image: UIImage(named: ImageConstant.clockOutline),
                                                        selectedImage: UIImage(named: ImageConstant.clockFilled))], animated: true)
    }

    func generateVC(viewController: UIViewController, image: UIImage?,
                    selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        return viewController
    }
}
