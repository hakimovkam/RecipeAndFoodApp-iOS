//
//  TimerListPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation
import RealmSwift

protocol TimerListViewProtocol: AnyObject {
    func didFailWithError(error: Error)
}

protocol TimerListViewPresenterProtocol: AnyObject {
    func didTapOnTimer(id: Int)
    func getTimerRecipes() -> Results<RealmRecipe>
    func saveOrDeleteFavoriteRecipe(id: Int, action: RealmCRUDAction)

    var recipes: [SearchResult]? { get set }
}

final class TimerListPresenter: TimerListViewPresenterProtocol {

    weak var view: TimerListViewProtocol?
    var router: RouterProtocol?
    @Autowired
    var networkService: NetworkServiceProtocol
    @Autowired
    var realmManager: RealmManagerProtocol

    required init(router: RouterProtocol) {
        self.router = router
    }

    var recipes: [SearchResult]?

    func didTapOnTimer(id: Int) {
        router?.showTimer(id: id)
    }

    func getTimerRecipes() -> Results<RealmRecipe> {
        return realmManager.getFavoriteRecipesInRealm().filter("isRecipeInTimerList == true")
    }

    func saveOrDeleteFavoriteRecipe(id: Int, action: RealmCRUDAction) {
        guard let recipe = realmManager.getFavoriteRecipesInRealm().realm?.object(ofType: RealmRecipe.self, forPrimaryKey: id) else { return }
        realmManager.recipeRealmInteraction(recipe: DetailRecipe(managedObject: recipe), action: action)
    }
}
