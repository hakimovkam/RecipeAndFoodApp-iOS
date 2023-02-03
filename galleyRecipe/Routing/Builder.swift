//
//  Builder.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func showIngredientsViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func createTimerListViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func showTimerViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func createSearchViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritePresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
    
    func createTimerListViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = TimerListViewController()
        let presenter = TimerListPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
        
    func showIngredientsViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = IngredientViewController()
        let presenter = IngridientPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
    
    func showTimerViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = TimerViewController()
        let presenter = TimerPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
    
    
    func createSearchViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
    
}
