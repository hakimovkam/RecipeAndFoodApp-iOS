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
    func didTapOnRecipe()
}

final class FavoritePresenter: FavoriteViewPresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    func didTapOnRecipe() {
        router?.showIngredients()
    }   
}
