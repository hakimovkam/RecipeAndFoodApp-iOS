//
//  Router.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol RouterMain {
    var tabBarController: CustomTabBarController? { get set }
    var favoriteNavigationController : UINavigationController? { get set }
    var detailIngredNavigationController: UINavigationController? { get set }
    var timerNavigationController: UINavigationController? { get set }
    var searchNavigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBarController()
    func showIngredients(_ checkRootView: Int)
    func goBackToFavoriteView()
    func showTimer()
    func goBackToTimerList()
}

class Router: RouterProtocol {
    
    var  builder: BuilderProtocol?
     
    weak var favoriteNavigationController: UINavigationController?
    weak var detailIngredNavigationController: UINavigationController?
    weak var timerNavigationController: UINavigationController?
    weak var searchNavigationController: UINavigationController?
    weak var tabBarController: CustomTabBarController?
    
    /* Иницилизация интернет прослойки в единственном экземпляре для передачи по модулям MVP */
    lazy private var networkService: NetworkServiceProtocol = NetworkService()
    
    /* Иницилизация TabBarController */
    init(tabBarController: CustomTabBarController,
         builder: BuilderProtocol,
         favoriteNavigationController: UINavigationController,
         detailIngredNavigationController: UINavigationController,
         timerNavigationController: UINavigationController,
         searchNavigationController: UINavigationController) {
        self.tabBarController = tabBarController
        self.favoriteNavigationController = favoriteNavigationController
        self.detailIngredNavigationController = detailIngredNavigationController
        self.timerNavigationController = timerNavigationController
        self.searchNavigationController = searchNavigationController
        self.builder = builder
    }
    
    func showIngredients(_ checkRootView: Int) {
        if checkRootView == 1 {
            guard let ingredientsViewController = builder?.showIngredientsViewController(router: self, networkService: networkService) else { return }
            favoriteNavigationController?.pushViewController(ingredientsViewController,  animated: true)
        } else { guard let ingredientsViewController = builder?.showIngredientsViewController(router: self, networkService: networkService) else { return }
            searchNavigationController?.pushViewController(ingredientsViewController, animated: true)
        }
    }
    
    func goBackToFavoriteView() {
        if let favoriteNavigationController = favoriteNavigationController {
            favoriteNavigationController.popToRootViewController(animated: true)
        }
    }
    
    func showTimer() {
        guard let timerViewController = builder?.showTimerViewController(router: self, networkService: networkService) else { return }
        timerNavigationController?.pushViewController(timerViewController, animated: true)
    }
    
    func goBackToTimerList() {
        if let timerNavigationController = timerNavigationController {
            timerNavigationController.popToRootViewController(animated: true)
        }
    }
    
    /* Заполняем TabBarController вкладками */
    func setupTabBarController() {
        /* иницилизирууем NavigationController для каждой вкладочки на TabBar */
        guard let favoriteViewController = builder?.createFavoriteViewController(router: self, networkService: networkService) else { return }
        favoriteNavigationController?.viewControllers = [favoriteViewController]
        
        guard let timerListViewController = builder?.createTimerListViewController(router: self, networkService: networkService) else { return }
        timerNavigationController?.viewControllers = [timerListViewController]
        
        guard let searchViewController = builder?.createSearchViewController(router: self, networkService: networkService) else { return }
        searchNavigationController?.viewControllers = [searchViewController]
        
        

        /* добавляем Item на TabBar и задаём картиночку на иконку  */
        tabBarController?.setViewControllers([generateVC(viewController: favoriteNavigationController!,
                                                         image: UIImage(named: ImageConstant.savedOutline),
                                                        selectedImage: UIImage(named: ImageConstant.savedFilled)),
                                             generateVC(viewController: searchNavigationController!,
                                                        image: UIImage(named: ImageConstant.recipeOutline),
                                                        selectedImage: UIImage(named: ImageConstant.recipeFilled)),
                                             generateVC(viewController: timerNavigationController!,
                                                        image: UIImage(named: ImageConstant.clockOutline),
                                                        selectedImage: nil)], animated: true)
    }

    //MARK: - cusstomize TabBarController
    /* Установка иконок и надписей на бэйджики */
    func generateVC(viewController: UIViewController,
                            image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        return viewController
    }
}
