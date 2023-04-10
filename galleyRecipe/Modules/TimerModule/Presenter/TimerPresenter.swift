//
//  TimerPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation
import RealmSwift

protocol TimerViewProtocol: AnyObject {
    func didFailWithError(error: Error)
}

protocol TimerViewPresenterProtocol: AnyObject {
    func backButtonDidPressed()
    func getRecipeById(id: Int)
    var id: Int { get }
    var recipe: DetailRecipe? { get set }
}

final class TimerPresenter: TimerViewPresenterProtocol {

    weak var view: TimerViewProtocol?
    var router: RouterProtocol?
    @Autowired
    var networkService: NetworkServiceProtocol
    @Autowired
    var realmManager: RealmManagerProtocol
    var id: Int
    var recipe: DetailRecipe?

    required init(router: RouterProtocol, id: Int) {
        self.id = id
        self.router = router
  
        getRecipeById(id: id)
    }

    func getRecipeById(id: Int) {
        recipe = realmManager.getRecipeByIdFromRealm(id: id)
    }

    func backButtonDidPressed() {
        router?.goBackToRootView()
    }
}
