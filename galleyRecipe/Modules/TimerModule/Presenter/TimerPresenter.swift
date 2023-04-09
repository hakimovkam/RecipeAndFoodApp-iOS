//
//  TimerPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation

protocol TimerViewProtocol: AnyObject {
    func didFailWithError(error: Error)
}

protocol TimerViewPresenterProtocol: AnyObject {
    func backButtonDidPressed()
}

final class TimerPresenter: TimerViewPresenterProtocol {

    weak var view: TimerViewProtocol?
    var router: RouterProtocol?
    @Autowired
    var networkService: NetworkServiceProtocol

    required init(router: RouterProtocol) {
        self.router = router
    }

    func backButtonDidPressed() {
        router?.goBackToRootView()
    }
}
