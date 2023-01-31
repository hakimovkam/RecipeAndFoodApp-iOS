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
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBarController()
    func showIngredients()
    func showTimer()
}

class Router: RouterProtocol {
    
    var  builder: BuilderProtocol?
     
    weak var favoriteNavigationController: UINavigationController?
    weak var detailIngredNavigationController: UINavigationController?
    weak var timerNavigationController: UINavigationController?
    weak var tabBarController: CustomTabBarController?
    
    /* Иницилизация интернет прослойки в единственном экземпляре для передачи по модулям MVP */
    lazy private var networkService: NetworkServiceProtocol = NetworkService()
    
    /* Иницилизация TabBarController */
    init(tabBarController: CustomTabBarController, builder: BuilderProtocol, favoriteNavigationController: UINavigationController, detailIngredNavigationController: UINavigationController,
         timerNavigationController: UINavigationController) {
        self.tabBarController = tabBarController
        self.favoriteNavigationController = favoriteNavigationController
        self.detailIngredNavigationController = detailIngredNavigationController
        self.timerNavigationController = timerNavigationController
        self.builder = builder
    }
    
    func showIngredients() {
        guard let ingredientsViewController = builder?.showIngredientsViewController(router: self, networkService: networkService) else { return }
        favoriteNavigationController?.pushViewController(ingredientsViewController,  animated: true)
    }
    
    func showTimer() {
        guard let timerViewController = builder?.showTimerViewController(router: self, networkService: networkService) else { return }
        timerNavigationController?.pushViewController(timerViewController, animated: true)
    }
    
    /* Заполняем TabBarController вкладками */
    func setupTabBarController() {
        /* иницилизирууем NavigationController для каждой вкладочки на TabBar */
        guard let favoriteViewController = builder?.createFavoriteViewController(router: self, networkService: networkService) else { return }
        favoriteNavigationController?.viewControllers = [favoriteViewController]
        
        guard let timerListViewController = builder?.createTimerListViewController(router: self, networkService: networkService) else { return }
        timerNavigationController?.viewControllers = [timerListViewController]
        

        /* добавляем Item на TabBar и задаём картиночку на иконку  */
        tabBarController?.setViewControllers([generateVC(viewController: favoriteNavigationController!,
                                                         image: UIImage(named: ImageConstant.savedOutline),
                                                        selectedImage: UIImage(named: ImageConstant.savedFilled)),
                                             generateVC(viewController: SearchViewController(),
                                                        image: UIImage(named: ImageConstant.recipeOutline),
                                                        selectedImage: UIImage(named: ImageConstant.recipeFilled)),
                                             generateVC(viewController: timerNavigationController!,
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
