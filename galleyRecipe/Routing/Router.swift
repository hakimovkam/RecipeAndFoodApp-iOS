//
//  Router.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol RouterMain {
    var tabBarController: CustomTabBarController? { get set }
    var builder: BuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBarController()
}

class Router: RouterProtocol {
    
    var  builder: BuilderProtocol
    weak var tabBarController: CustomTabBarController?  // нужно сделать слабую ссылку weak var (разобраться как это работает)
    
    /* Иницилизация интернет прослойки в единственном экземпляре для передачи по модулям MVP */
    lazy private var networkService: NetworkServiceProtocol = NetworkService()
    
    /* Иницилизация TabBarController */
    init(tabBarController: CustomTabBarController, builder: BuilderProtocol) {
        self.tabBarController = tabBarController
        self.builder = builder
    }
    
    /* Заполняем TabBarController вкладками */
    func setupTabBarController() {
        /* иницилизирууем NavigationController для каждой вкладочки на TabBar */
        let favoriteViewController = UINavigationController(rootViewController: builder.createFavoriteViewController(router: self, networkService: networkService))

        /* добавляем Item на TabBar и задаём картиночку на иконку  */
        tabBarController?.setViewControllers([generateVC(viewController: favoriteViewController,
                                                         image: UIImage(named: ImageConstant.savedOutline),
                                                        selectedImage: UIImage(named: ImageConstant.savedFilled)),
                                             generateVC(viewController: SearchViewController(),
                                                        image: UIImage(named: ImageConstant.recipeOutline),
                                                        selectedImage: UIImage(named: ImageConstant.recipeFilled)),
                                             generateVC(viewController: UIViewController(),
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
