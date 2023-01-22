//
//  ViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 21.01.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarApperance()
    }
    
    //MARK: - cusstomize TabBarController

    /* Кастомизация TabBarControllera
     Тут нужно будет поиграться с размерами, закруглениями и тд. для того чтоб сделать всё такое же как и в дизайне
     + подобрать цвета
     */
    func setTabBarApperance() {
        let positionOnX: CGFloat = 80
        let positionOnY: CGFloat = 1
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2 * 15

        let rounderLayer = CAShapeLayer()
        let bezierPath =  UIBezierPath(roundedRect: CGRect(x:  positionOnX,
                                                           y: tabBar.bounds.minY - positionOnY - 20,
                                                           width: width,
                                                           height: height),
                                       cornerRadius: height / 3.095)

        rounderLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(rounderLayer, at: 0)
        tabBar.itemWidth = width / 5 // distance between tab bar items
        tabBar.itemPositioning = .centered

        /* Цвета для кастома TabBarControllera задаются тут */
        rounderLayer.fillColor = UIColor.white.cgColor
        tabBar.tintColor = UIColor.black

        /* Задник за TabBarController делается прозрачным */
//        let appearance = UITabBarAppearance()
//        appearance.configureWithTransparentBackground()
//        tabBarController.tabBar.standardAppearance = appearance

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.configureWithDefault(for: .compactInline)


        /* В блоке кода ниже задаётся линия вокргу TabBarController */
        tabBar.layer.shadowColor = UIColor.darkGray.cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 0.5
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
}
