//
//  FavoritePresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func didUpdate()
    func didFailWithError(error: Error)
}

protocol FavoriteViewPresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func tapOnTheRecipe()
    func tapOnTheBackButton()
}

class FavoritePresenter: FavoriteViewPresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: FavoriteViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func tapOnTheRecipe() {
        router?.showIngredients()
    }
    
    func tapOnTheBackButton() {
        router
    }
    
    /* Через презентер обращаемся к networkService и вытаскиваем список Characters */
//    func getCharacterList() {
//        networkService.getCharactersList { [weak self] result in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let characters):
//                    self.characters = characters
//                    self.view?.didUpdateCharacters()
//                case .failure(let error):
//                    self.view?.didFailWithError(error: error)
//                }
//            }
//        }
//    }
    

    
    
}
