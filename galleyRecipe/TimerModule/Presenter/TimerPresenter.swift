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
    func backButtonInTimerDidPressed()
}

final class TimerPresenter: TimerViewPresenterProtocol {
    
    
    weak var view: TimerViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    func backButtonInTimerDidPressed() {
        router?.goBackToRootView()
    }
}
