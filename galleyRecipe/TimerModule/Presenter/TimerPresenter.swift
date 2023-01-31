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
    init (view: TimerViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
}

class TimerPresenter: TimerViewPresenterProtocol {
    
    weak var view: TimerViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: TimerViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
}
