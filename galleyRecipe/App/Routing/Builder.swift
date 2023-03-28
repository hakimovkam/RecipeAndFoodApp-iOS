//
//  Builder.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import UIKit

protocol BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol) -> UIViewController
    func showIngredientsViewController(router: RouterProtocol, id: Int?) -> UIViewController
    func createTimerListViewController(router: RouterProtocol) -> UIViewController
    func showTimerViewController(router: RouterProtocol) -> UIViewController
    func createSearchViewController(router: RouterProtocol) -> UIViewController
}

struct Builder: BuilderProtocol {
    func createFavoriteViewController(router: RouterProtocol) -> UIViewController {
        let presenter = FavoritePresenter(router: router)
        let view = FavoritesViewController(presenter: presenter)

        presenter.view = view
        return view
    }

    func createTimerListViewController(router: RouterProtocol) -> UIViewController {
        let presenter = TimerListPresenter(router: router)
        let view = TimerListViewController(presenter: presenter)

        presenter.view = view
        return view
    }

    func showIngredientsViewController(router: RouterProtocol, id: Int?) -> UIViewController {
        let presenter = IngridientPresenter(router: router, id: id)
        let view = IngredientsViewController(presenter: presenter)

        presenter.view = view
        return view
    }

    func showTimerViewController(router: RouterProtocol) -> UIViewController {
        let presenter = TimerPresenter(router: router)
        let view = TimerViewController(presenter: presenter)

        presenter.view = view
        return view
    }

    func createSearchViewController(router: RouterProtocol) -> UIViewController {
        let presenter = SearchPresenter(router: router)
        let view = SearchViewController(presenter: presenter)

        presenter.view = view
        return view
    }
}
