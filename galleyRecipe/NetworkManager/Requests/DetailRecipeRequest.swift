//
//  DetailRecipeRequest.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 13.02.2023.
//

import Foundation

struct DetailResipeRequest: DataRequest {

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> DetailRecipe {
        let decoder = JSONDecoder()

        let response = try decoder.decode(DetailRecipe.self, from: data)
        return response
    }
}
