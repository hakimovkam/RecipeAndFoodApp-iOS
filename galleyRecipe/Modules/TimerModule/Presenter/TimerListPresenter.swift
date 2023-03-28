//
//  TimerListPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation

protocol TimerListViewProtocol: AnyObject {
    func didFailWithError(error: Error)
}

protocol TimerListViewPresenterProtocol: AnyObject {
    func didTapOnTimer()
}

final class TimerListPresenter: TimerListViewPresenterProtocol {

    weak var view: TimerListViewProtocol?
    var router: RouterProtocol?
    @Autowired
    var networkService: NetworkServiceProtocol

    required init(router: RouterProtocol) {
        self.router = router
    }

    func didTapOnTimer() {
        router?.showTimer()
    }
}
