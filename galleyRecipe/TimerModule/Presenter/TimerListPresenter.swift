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
    init (view: TimerListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func tapOnTheTimer()
}

class TimerListPresenter: TimerListViewPresenterProtocol {
    
    weak var view: TimerListViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: TimerListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    func tapOnTheTimer() {
        router?.showTimer()
    }
    
    
}
