//
//  Presenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 03.02.2023.
//

import Foundation
import RealmSwift

enum UpdateQueryItemsArray {
    case update
    case delete
    case add
}

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func loadNewRecipes(dataCount: Int, newDataCount: Int)
}

protocol SearchViewPresenterProtocol: AnyObject {
    func tapOnTheRecipe(id: Int?)
    func getRecipes()
    func setDeafaultChips()
    func getMealObjs() -> Results<RealmChipsMealType>
    func getCuisineObjs() -> Results<RealmChipsCuisineType>
    func updateMealItem(indexPath: Int)
    func updateCuisineItem(indexPath: Int)
    func updateQueryItems(key: QueryItemKeys, itemValue: String, oldItemValue: String?, action: UpdateQueryItemsArray)
    func saveOrDeleteFavoriteRecipe(id: Int, action: RealmCRUDAction)
    func checkRecipeInRealm(id: Int) -> Bool
    func checkCountryInRealm(country: String) -> Bool
    func loadNewRecipes()

    var recipes: [SearchResult]? { get set }
    var totalResults: Int? { get set }
    var queryItems: [URLQueryItem] { get set }
    var offset: Int { get set }

}

class SearchPresenter: SearchViewPresenterProtocol {

    weak var view: SearchViewProtocol?
    var router: RouterProtocol?
    @Autowired
    private var networkService: NetworkServiceProtocol
    @Autowired
    private var realmManager: RealmManagerProtocol

    required init(router: RouterProtocol) {
        self.router = router
        getRecipes()
    }

    // MARK: - routing
    func tapOnTheRecipe(id: Int?) {
        router?.showIngredients(id: id)
    }

    // MARK: - networkService

    var recipes: [SearchResult]?
    var totalResults: Int?
    var offset: Int = 0

    var queryItems: [URLQueryItem] = []

    func updateQueryItems(key: QueryItemKeys, itemValue: String, oldItemValue: String?, action: UpdateQueryItemsArray) {
        let queryItem = URLQueryItem(name: key.rawValue, value: itemValue)

        switch action {
        case .add:
            queryItems.append(queryItem)
        case .update:
            guard let oldItemValue = oldItemValue else { return }
            queryItems.removeAll(where: { queryItem in
                queryItem.value == oldItemValue
            })
            queryItems.append(queryItem)
        case .delete:
            queryItems.removeAll(where: { queryItem in
                queryItem.value == itemValue
            })
        }

        if key.rawValue != "offset" {
            queryItems.removeAll(where: { queryItem in
                queryItem.name == "offset"
            })
            recipes = nil
            offset = 0
        }

        getRecipes()
    }

    func getRecipes() {
        let request = SearchRecipeRequest(requestType: .recepts, queryItems: queryItems)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self.totalResults = recipes.totalResults
                    if self.offset == recipes.offset && recipes.totalResults >= self.recipes?.count ?? 0 {
                        if self.recipes != nil {
                            let dataCount = self.recipes?.count ?? 0
                            self.recipes?.append(contentsOf: recipes.results)
                            self.view?.loadNewRecipes(dataCount: dataCount, newDataCount: dataCount + recipes.results.count)
                        } else {
                            self.recipes = recipes.results
                            self.view?.success()
                        }
                        if self.recipes?.count ?? 0 <= recipes.totalResults {
                            self.offset += recipes.number
                        }
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }

    func loadNewRecipes() {
        queryItems.removeAll(where: { queryItem in
            queryItem.name == "offset"
        })
        queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        getRecipes()
    }

    // MARK: - realChipsManager
    func setDeafaultChips() { realmManager.setDefaultValueForChips() }

    func getMealObjs() -> Results<RealmChipsMealType> { return realmManager.getMealTypeItems() }

    func getCuisineObjs() -> Results<RealmChipsCuisineType> { return realmManager.getCuisineTypeItems() }

    func updateMealItem(indexPath: Int) { realmManager.updateMealTypeItem(indexPath: indexPath)}

    func updateCuisineItem(indexPath: Int) { realmManager.updateCuisineType(indexPath: indexPath)}

    // MARK: - realFavoriteManager
    func saveOrDeleteFavoriteRecipe(id: Int, action: RealmCRUDAction) {
        let request = DetailResipeRequest(id: id, requestType: .detailed)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.realmManager.recipeRealmInteraction(recipe: recipe, action: action)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }

    }

    func checkRecipeInRealm(id: Int) -> Bool {
        return realmManager.checkFavoriteRecipeInRealmById(id: id)
    }

    func checkCountryInRealm(country: String) -> Bool { return realmManager.checkCountryInRealm(country: country) }
}
