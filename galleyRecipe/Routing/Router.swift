//
//  Router.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol RouterMain {
    var rootController: UINavigationController? { get set }
    var favoriteViewController : UIViewController? { get set }
    var timerViewController: UIViewController? { get set }
    var searchViewController: UIViewController? { get set }
    var tabBarController: CustomTabBarController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBarController()
    func showIngredients()
    func goBackToRootView()
    func showTimer()
}

class Router: RouterProtocol {
    
    var  builder: BuilderProtocol?
     
    weak var favoriteViewController: UIViewController?
    weak var timerViewController: UIViewController?
    weak var searchViewController: UIViewController?
    weak var rootController: UINavigationController?
    weak var tabBarController: CustomTabBarController?
    
    /* Иницилизация интернет прослойки в единственном экземпляре для передачи по модулям MVP */
    lazy private var networkService: NetworkServiceProtocol = NetworkService()
    
    /* Иницилизация TabBarController */
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
            guard let ingredientsViewController = builder?.showIngredientsViewController(router: self, networkService: networkService) else { return }
            rootController?.pushViewController(ingredientsViewController, animated: true)
    }
    
    func goBackToRootView() {
        if let rootController = rootController {
            rootController.popToRootViewController(animated: true)
        }
    }
    
    func showTimer() {
        guard let timerViewController = builder?.showTimerViewController(router: self, networkService: networkService) else { return }
        rootController?.pushViewController(timerViewController, animated: true)
    }
    
    /* Заполняем TabBarController вкладками */
    func setupTabBarController() {
        /* иницилизирууем NavigationController для каждой вкладочки на TabBar */
        guard let favoriteView = builder?.createFavoriteViewController(router: self, networkService: networkService) else { return }
//        favoriteViewController = favoriteView
//        favoriteNavigationController?.viewControllers = [favoriteViewController]

        guard let timerView = builder?.createTimerListViewController(router: self, networkService: networkService) else { return }
//        timerViewController = timerView
//        timerNavigationController?.viewControllers = [timerListViewController]

        guard let searchView = builder?.createSearchViewController(router: self, networkService: networkService) else { return }
//        searchNavigationController?.viewControllers = [searchViewController]
//        searchViewController = searchView



        /* добавляем Item на TabBar и задаём картиночку на иконку  */
        tabBarController?.setViewControllers([generateVC(viewController: favoriteView,
                                                         image: UIImage(named: ImageConstant.savedOutline),
                                                        selectedImage: UIImage(named: ImageConstant.savedFilled)),
                                             generateVC(viewController: searchView,
                                                        image: UIImage(named: ImageConstant.recipeOutline),
                                                        selectedImage: UIImage(named: ImageConstant.recipeFilled)),
                                             generateVC(viewController: timerView ,
                                                        image: UIImage(named: ImageConstant.clockOutline),
                                                        selectedImage: nil)], animated: true)
    }
    
    /* по возможности функцию выше setupTabBarController нужно перенести в builder */
    
    //MARK: - cusstomize TabBarController
    /* Установка иконок и надписей на бэйджики */
    func generateVC(viewController: UIViewController,
                            image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        return viewController
    }
}
