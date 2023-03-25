//
//  Builder.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol, networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol) -> UIViewController
    func showIngredientsViewController(router: RouterProtocol, networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol, id: Int?) -> UIViewController
    func createTimerListViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func showTimerViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController
    func createSearchViewController(router: RouterProtocol, networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol) -> UIViewController
}

struct Builder: BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol, networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol) -> UIViewController {
        let presenter = FavoritePresenter(networkService: networkService, router: router, realmManager: realmManager)
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

    func showIngredientsViewController(router: RouterProtocol, networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol, id: Int?) -> UIViewController {
        let presenter = IngridientPresenter(networkService: networkService, realmManager: realmManager, router: router, id: id)
        let view = IngredientsViewController(presenter: presenter)

        presenter.view = view
        return view
    }

    func showTimerViewController(router: RouterProtocol, networkService: NetworkServiceProtocol) -> UIViewController {
        let presenter = TimerPresenter(networkService: networkService, router: router)
        let view = TimerViewController(presenter: presenter)

        presenter.view = view
        return view
    }

    func createSearchViewController(router: RouterProtocol, networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol) -> UIViewController {
        let presenter = SearchPresenter(networkService: networkService, router: router, realmManager: realmManager)
        let view = SearchViewController(presenter: presenter)

        presenter.view = view
        return view
    }
}
