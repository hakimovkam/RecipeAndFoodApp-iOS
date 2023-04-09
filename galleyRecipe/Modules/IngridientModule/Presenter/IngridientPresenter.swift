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
    func saveDeleteFavoriteRecipe(recipe recipeForSaving: DetailRecipe, action: RealmCRUDAction)
    func checkRecipeInRealm(id: Int) -> Bool
    func updateRecipeInfo(servings: Int, calorie: Double)
    var recipe: DetailRecipe? { get set }
}

final class IngridientPresenter: IngridientViewPresenterProtocol {

    weak var view: IngridientViewProtocol?
    var router: RouterProtocol?
    var id: Int?
    var recipe: DetailRecipe?
    @Autowired
    var networkService: NetworkServiceProtocol
    @Autowired
    var realmManager: RealmManagerProtocol

    required init(router: RouterProtocol, id: Int?) {
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

    func saveDeleteFavoriteRecipe(recipe recipeForSaving: DetailRecipe, action: RealmCRUDAction) {
        realmManager.changeFavoriteRecipeInRealm(recipe: recipeForSaving, action: action)
    }

    func checkRecipeInRealm(id: Int) -> Bool {
        return realmManager.checkFavoriteRecipeInRealmById(id: id)
    }

    func updateRecipeInfo(servings: Int, calorie: Double) {
        guard let id = recipe?.id else { return }
        realmManager.updateRecipeInfo(servings: servings, calorie: calorie, id: id)
    }
}
