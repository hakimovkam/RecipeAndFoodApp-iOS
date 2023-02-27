//
//  SearchRecipeRequest.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 19.02.2023.
//

import Foundation

struct SearchRecipeRequest: DataRequest {

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> SearchRecipeModel {
        let decoder = JSONDecoder()

        let response = try decoder.decode(SearchRecipeModel.self, from: data)
        return response
    }
}
