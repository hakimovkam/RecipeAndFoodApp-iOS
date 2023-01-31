//
//  IngridientPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation

protocol IngridientViewProtocol: AnyObject {
//    func didUpdate()
//    func didFailWithError(error: Error)
}

protocol IngridientViewPresenterProtocol: AnyObject {
    init(view: IngridientViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) // в иницилизацию еще нужно опрокинуть модельку
}

class IngridientPresenter: IngridientViewPresenterProtocol {
    
    weak var view: IngridientViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: IngridientViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        
    }
    
    
}
