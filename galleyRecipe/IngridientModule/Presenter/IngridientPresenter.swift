//
//  IngridientPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation

protocol IngridientViewProtocol: AnyObject {
}

protocol IngridientViewPresenterProtocol: AnyObject {
    var view: IngridientViewProtocol? { get set }
    func backButtonInIngredientDidPressed()
}

final class IngridientPresenter: IngridientViewPresenterProtocol {
    
    weak var view: IngridientViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    func backButtonInIngredientDidPressed() {
        router?.goBackToFavoriteView()
    }
}
