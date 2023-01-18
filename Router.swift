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
        
//        self.tabBarController.tabBar.tintColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        self.tabBarController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)

        self.tabBarController.tabBar.isTranslucent = false
        
    }
    
    func setupTabBarController() {
        let characterViewController = UINavigationController(rootViewController: builder.createCharecterModule(router: self, networkService: networkService))
        let locationViewController = UINavigationController(rootViewController: builder.createLocationModule(router: self, networkService: networkService))
        
        tabBarController.setViewControllers([generateVC(viewController: characterViewController, title: "Characters", image: UIImage(systemName: "person")), generateVC(viewController: locationViewController, title: "Location", image: UIImage(systemName: "globe.asia.australia.fill"))], animated: true)
        setTabBarApperance()
    }
    
    
    
    
    //MARK: - cusstomize TabBarController
    /* Установка иконок и надписей на бэйджики */
    private func generateVC(viewController: UIViewController,
                            title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    /* Кастомизация TabBarControllera*/
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
        
        
        
        rounderLayer.fillColor = UIColor.mainWhite.cgColor
        tabBarController.tabBar.tintColor = UIColor.tabBarItemAccent
        tabBarController.tabBar.unselectedItemTintColor = UIColor.tabBarItemLight
    }
}
