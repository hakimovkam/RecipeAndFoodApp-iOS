//
//  FavoritePresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import Foundation
import RealmSwift

protocol FavoriteViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol FavoriteViewPresenterProtocol: AnyObject {
    func didTapOnRecipe()
    func checkRecipeInRealm(id: Int) -> Bool
    func getFavoriteObjs() -> Results<RealmFavoriteRecipe>
    func saveOrDeleteFavoriteRecipe(id: Int)
    func getResultsByRequestFromSearchBar(request: String?) -> Results<RealmFavoriteRecipe>
    var recipes: [SearchResult]? { get set }
}

final class FavoritePresenter: FavoriteViewPresenterProtocol {

    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    let realmManager: RealmManagerProtocol

    var recipes: [SearchResult]?

    required init(networkService: NetworkServiceProtocol, router: RouterProtocol, realmManager: RealmManagerProtocol) {
        self.networkService = networkService
        self.realmManager = realmManager
        self.router = router
    }

    func didTapOnRecipe() {
        router?.showIngredients()
    }

    func saveOrDeleteFavoriteRecipe(id: Int) {
        guard let recipe = realmManager.getFavoriteRecipesInRealm().realm?.object(ofType: RealmFavoriteRecipe.self, forPrimaryKey: id) else { return }
        realmManager.changeFavoriteRecipeInRealm(recipe: DetailRecipe(managedObject: recipe))
    }

    func checkRecipeInRealm(id: Int) -> Bool { return realmManager.checkRecipeInRealmById(id: id)}

    func getFavoriteObjs() -> Results<RealmFavoriteRecipe> { return realmManager.getFavoriteRecipesInRealm() }

    func getResultsByRequestFromSearchBar(request: String?) -> Results<RealmFavoriteRecipe> {
        let recipes = realmManager.getFavoriteRecipesInRealm()

        guard let request = request else {
            return recipes
        }

        let lowercaseRequest = request.lowercased()
        let result = recipes.filter("title CONTAINS[c] %@", lowercaseRequest)

        return result
    }
}
