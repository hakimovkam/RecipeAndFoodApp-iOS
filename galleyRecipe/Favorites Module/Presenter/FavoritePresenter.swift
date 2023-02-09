//
//  FavoritePresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func didUpdate()
    func didFailWithError(error: Error)
}

protocol FavoriteViewPresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func didTapOnRecipe()
}

class FavoritePresenter: FavoriteViewPresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: FavoriteViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func didTapOnRecipe() {
        router?.showIngredients()
    }   
}
