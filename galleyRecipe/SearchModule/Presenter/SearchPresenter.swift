//
//  Presenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 03.02.2023.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol SearchViewPresenterProtocol: AnyObject {
    func tapOnTheRecipe()
    func getRecipes()
    var recipes: [SearchResult]?  { get set }
}

class SearchPresenter: SearchViewPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
//        getRecipes()
    }
    
    var recipes: [SearchResult]?
    
    func tapOnTheRecipe() {
        router?.showIngredients()
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
}
