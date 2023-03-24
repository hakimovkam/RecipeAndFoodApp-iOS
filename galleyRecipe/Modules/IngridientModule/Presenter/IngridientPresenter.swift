//
//  IngridientPresenter.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 31.01.2023.
//

import Foundation

protocol IngridientViewProtocol: AnyObject {
    func failure()
    func setDataToView(recipe: DetailRecipe?)
}

protocol IngridientViewPresenterProtocol: AnyObject {
    func setDataToView()
    func backButtonDidPressed()
}

final class IngridientPresenter: IngridientViewPresenterProtocol {

    weak var view: IngridientViewProtocol?
    var router: RouterProtocol?
    var id: Int?
    var recipe: DetailRecipe?
    let networkService: NetworkServiceProtocol

    required init(networkService: NetworkServiceProtocol, router: RouterProtocol, id: Int?) {
        self.networkService = networkService
        self.router = router
        self.id = id
        getRecipe(id: id)
    }

    func backButtonDidPressed() {
        router?.goBackToRootView()
    }

    func getRecipe(id: Int?) {
        let request = DetailResipeRequest(id: id, requestType: .detailed)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipe):
                    self.recipe = recipe
                    self.setDataToView()
                case .failure(let error):
                    print(error.description)
//                    self.view?.failure(error: error)
                }
            }
        }
    }

    func setDataToView() {
        self.view?.setDataToView(recipe: recipe)
    }
}
