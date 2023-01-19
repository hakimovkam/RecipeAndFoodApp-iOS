//
//  Router.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol RouterMain {
    var tabBarController: UITabBarController { get set }
    var builder: BuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBarController()
}

class Router: RouterProtocol {
    
    var  builder: BuilderProtocol
    var tabBarController: UITabBarController
    
    /* Иницилизация интернет прослойки в единственном экземпляре для передачи по модулям MVP */
    lazy private var networkService: NetworkServiceProtocol = NetworkService()
    
    /* Иницилизация TabBarController */
    init(tabBarController: UITabBarController, builder: BuilderProtocol) {
        self.tabBarController = tabBarController
        self.builder = builder
        
    }
    
    func setupTabBarController() {
        /* иницилизирууем NavigationController для каждой вкладочки на TabBar */
        let favoriteViewController = UINavigationController(rootViewController: builder.createFavoriteViewController(router: self, networkService: networkService))

        
        /* добавляем Item на TabBar и задаём картиночку на иконку  */
        tabBarController.setViewControllers([generateVC(viewController: favoriteViewController, image: UIImage(systemName: "person"))], animated: true)
        setTabBarApperance()
    }
    
    
    
    
    //MARK: - cusstomize TabBarController
    /* Установка иконок и надписей на бэйджики */
    private func generateVC(viewController: UIViewController,
                            image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
    /* Кастомизация TabBarControllera
     Тут нужно будет поиграться с размерами, закруглениями и тд. для того чтоб сделать всё такое же как и в дизайне
     + подобрать цвета
     */
    private func setTabBarApperance() {
        let positionOnX: CGFloat = 0
        let positionOnY: CGFloat = 10
        let width = tabBarController.tabBar.bounds.width - positionOnX * 5
        let height = tabBarController.tabBar.bounds.height + positionOnY * 8
        
        let rounderLayer = CAShapeLayer()
        
        let bezierPath =  UIBezierPath(roundedRect: CGRect(x:  positionOnX,
                                                           y: tabBarController.tabBar.bounds.minY - positionOnY ,
                                                           width: width,
                                                           height: height),
                                       cornerRadius: height / 3.5)
        
        rounderLayer.path = bezierPath.cgPath
        tabBarController.tabBar.layer.insertSublayer(rounderLayer, at: 0)
        tabBarController.tabBar.itemWidth = width / 6.7 // distance between tab bar items
        tabBarController.tabBar.itemPositioning = .centered
        
        
        /* цвета для кастома TabBarControllera задаются тут */
        rounderLayer.fillColor = UIColor.mainWhite.cgColor
//        tabBarController.tabBar.tintColor = UIColor.tabBarItemAccent
//        tabBarController.tabBar.unselectedItemTintColor = UIColor.tabBarItemLight
    }
}
