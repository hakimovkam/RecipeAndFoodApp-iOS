//
//  IngridientPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation

protocol IngridientViewProtocol: AnyObject {
    func failure()
    func setDataToView(recipe: DetailRecipe?)
}

protocol IngridientViewPresenterProtocol: AnyObject {
    func backButtonDidPressed()
    func saveDeleteFavoriteRecipe(recipe recipeForSaving: DetailRecipe)
    func checkRecipeInRealm(id: Int) -> Bool
    var recipe: DetailRecipe? { get set }
}

final class IngridientPresenter: IngridientViewPresenterProtocol {

    weak var view: IngridientViewProtocol?
    var router: RouterProtocol?
    var id: Int?
    var recipe: DetailRecipe?
    let networkService: NetworkServiceProtocol
    let realmManager: RealmManagerProtocol

    required init(networkService: NetworkServiceProtocol, realmManager: RealmManagerProtocol, router: RouterProtocol, id: Int?) {
        self.networkService = networkService
        self.realmManager = realmManager
        self.router = router
        self.id = id
        getRecipe(id: id)
    }

    func backButtonDidPressed() {
        router?.goBackToRootView()
    }

    func downloadRecipe(id: Int?) {
        let request = DetailResipeRequest(id: id, requestType: .detailed)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.recipe = recipe
                    self.view?.setDataToView(recipe: recipe)
                case .failure(let error):
                    self.view?.failure()
                    print(error.localizedDescription)
                }
            }
        }
    }

    func getRecipe(id: Int?) {
        if let recipeId  = id {
            if checkRecipeInRealm(id: recipeId) {
                recipe = realmManager.getFavoriteRecipeInRealm(id: recipeId)
                DispatchQueue.main.async {
                    self.view?.setDataToView(recipe: self.recipe)
                }
            } else {
                downloadRecipe(id: id)
            }
        }
    }

    func saveDeleteFavoriteRecipe(recipe recipeForSaving: DetailRecipe) {
        realmManager.changeFavoriteRecipeInRealm(recipe: recipeForSaving)
    }

    func checkRecipeInRealm(id: Int) -> Bool {
        return realmManager.checkRecipeInRealmById(id: id)
    }
}
