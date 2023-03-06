//
//  Presenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 03.02.2023.
//

import UIKit
import RealmSwift
import Kingfisher

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol SearchViewPresenterProtocol: AnyObject {
    func tapOnTheRecipe()
    func getRecipes()
    func setDeafaultChips()
    func getMealObjs() -> Results<RealmChipsMealType>
    func getCuisineObjs() -> Results<RealmChipsCuisineType>
    func updateMealItem(indexPath: Int)
    func updateCuisineItem(indexPath: Int)
    func updateMealQueryItems(key: QueryItemKeys, itemValue: String, append: Bool)
    func saveOrDeleteFavoriteRecipe(id: Int)
    func checkRecipeInRealm(id: Int) -> Bool

    var recipes: [SearchResult]? { get set }
    var totalResults: Int? { get set }
    var queryItems: [URLQueryItem] { get set }

}

class SearchPresenter: SearchViewPresenterProtocol {

    weak var view: SearchViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    let realmManager: RealmManagerProtocol

    required init(networkService: NetworkServiceProtocol, router: RouterProtocol, realmManager: RealmManagerProtocol) {
        self.router = router
        self.networkService = networkService
        self.realmManager = realmManager
        getRecipes()
    }

    // MARK: - routing
    func tapOnTheRecipe() { router?.showIngredients() }

    // MARK: - networkService

    var recipes: [SearchResult]?
    var totalResults: Int?

    var queryItems: [URLQueryItem] = []

    func updateMealQueryItems(key: QueryItemKeys, itemValue: String, append: Bool) {
        let queryItem = URLQueryItem(name: key.rawValue, value: itemValue)
        append ? queryItems.append(queryItem) : queryItems.removeAll(where: { queryItem in // swiftlint:disable:this void_function_in_ternary
            queryItem.value == itemValue
        })
        getRecipes()
    }

    func getRecipes() {

        let request = SearchRecipeRequest(requestType: .recepts, queryItems: queryItems)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.totalResults = recipe.totalResults
                    self.recipes = recipe.results
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }

    // MARK: - realChipsManager
    func setDeafaultChips() { realmManager.setDefaultValueForChips() }

    func getMealObjs() -> Results<RealmChipsMealType> { return realmManager.getMealTypeItems() }

    func getCuisineObjs() -> Results<RealmChipsCuisineType> { return realmManager.getCuisineTypeItems() }

    func updateMealItem(indexPath: Int) { realmManager.updateMealTypeItem(indexPath: indexPath)}

    func updateCuisineItem(indexPath: Int) { realmManager.updateCuisineType(indexPath: indexPath)}

    // MARK: - realFavoriteManager

    func saveOrDeleteFavoriteRecipe(id: Int) {
        let request = DetailResipeRequest(id: id, requestType: .detailed)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.realmManager.changeFavoriteRecipeInRealm(recipe: recipe)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }

    }

    func checkRecipeInRealm(id: Int) -> Bool { return realmManager.checkRecipeInRealmById(id: id)}

    //    func getFavoriteObjs() -> Results<RealmFavoriteRecipe> { return realmManager.getFavoriteRecipesInRealm() }
}
