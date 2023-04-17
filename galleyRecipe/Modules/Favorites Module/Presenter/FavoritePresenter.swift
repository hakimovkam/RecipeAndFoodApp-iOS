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
    func didTapOnRecipe(recipe: DetailRecipe)
    func checkRecipeInRealm(id: Int) -> Bool
    func getFavoriteRecipes() -> Results<RealmRecipe>
    func saveOrDeleteFavoriteRecipe(id: Int, action: RealmCRUDAction)
    func getResultsByRequestFromSearchBar(request: String?) -> Results<RealmRecipe>
    var recipes: [SearchResult]? { get set }
}

final class FavoritePresenter: FavoriteViewPresenterProtocol {

    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
    @Autowired
    private var networkService: NetworkServiceProtocol
    @Autowired
    private var realmManager: RealmManagerProtocol

    var recipes: [SearchResult]?

    required init(router: RouterProtocol) {
        self.router = router
    }

    func didTapOnRecipe(recipe: DetailRecipe) {
        router?.showIngredients(id: recipe.id)
    }

    func saveOrDeleteFavoriteRecipe(id: Int, action: RealmCRUDAction) {
        guard let recipe = realmManager.getFavoriteRecipesInRealm().realm?.object(ofType: RealmRecipe.self, forPrimaryKey: id) else { return }
        realmManager.recipeRealmInteraction(recipe: DetailRecipe(managedObject: recipe), action: action)
    }

    func checkRecipeInRealm(id: Int) -> Bool { return realmManager.checkFavoriteRecipeInRealmById(id: id)}

    func getFavoriteRecipes() -> Results<RealmRecipe> {
        return realmManager.getFavoriteRecipesInRealm().filter("isRecipeFavorite == true")
    }

    func getResultsByRequestFromSearchBar(request: String?) -> Results<RealmRecipe> {
        let recipes = realmManager.getFavoriteRecipesInRealm()

        guard let request = request else {
            return recipes
        }

        let lowercaseRequest = request.lowercased()
        let result = recipes.filter("title CONTAINS[c] %@", lowercaseRequest)

        return result
    }
}
