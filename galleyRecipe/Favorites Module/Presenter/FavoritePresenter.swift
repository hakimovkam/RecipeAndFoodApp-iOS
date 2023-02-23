//
//  FavoritePresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol FavoriteViewPresenterProtocol: AnyObject {
    func didTapOnRecipe()
    func getRecipes()
    var recipes: [SearchResult]? { get set }
}

final class FavoritePresenter: FavoriteViewPresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    
    var recipes: [SearchResult]?
    
    required init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
        getRecipes()
    }
    
    func getRecipes() {
        let request = SearchRecipeRequest()
        networkService.request(id: "", requestType: .recepts,
                               queryItemsArray: [],
                               request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.recipes = recipe
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func didTapOnRecipe() {
        router?.showIngredients()
    }
}
