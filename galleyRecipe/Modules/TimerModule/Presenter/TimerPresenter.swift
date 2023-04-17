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
    func getRecipe(id: Int)
    func getTimerStatus() -> Bool
    func updateTimerStatus(timerStatus: Bool)

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
        self.router = router
        self.id = id

        getRecipe(id: id)
    }

    func getRecipe(id: Int) {
        recipe = realmManager.getRecipeByIdFromRealm(id: id)
    }

    func getTimerStatus() -> Bool {
        guard let id = recipe?.id else { return false }
        return realmManager.getTimerStatus(id: id)
    }

    func updateTimerStatus(timerStatus: Bool) {
        guard let id = recipe?.id else { return }
        realmManager.updateTimerStatus(id: id, timerStatus: timerStatus)
    }

    func backButtonDidPressed() {
        router?.goBackToRootView()
    }
}
