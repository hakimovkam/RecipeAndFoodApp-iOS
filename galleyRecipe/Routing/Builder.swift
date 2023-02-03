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

final class Builder: BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let presenter = FavoritePresenter(networkService: networkService, router: router)
        let view = FavoritesViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
    
    func createTimerListViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let presenter = TimerListPresenter(networkService: networkService, router: router)
        let view = TimerListViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
        
    func showIngredientsViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let presenter = IngridientPresenter(networkService: networkService, router: router)
        let view = IngredientViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
    
    func showTimerViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let presenter = TimerPresenter(networkService: networkService, router: router)
        let view = TimerViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
    
    func createSearchViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let view = SearchViewController()
    
        
    }
    
        view.presenter = presenter
        return view
        let presenter = SearchPresenter(view: view, networkService: networkService, router: router)
}
