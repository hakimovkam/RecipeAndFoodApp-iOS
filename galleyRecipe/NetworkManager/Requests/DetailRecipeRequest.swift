//
//  DetailRecipeRequest.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 13.02.2023.
//

import Foundation

struct DetailResipeRequest: DataRequest {

//    private let apiKey: String = "997ced0c82834e24a3a3290f8123f2b5"
    private let apiKey: String = "6e58539408dd4110bba09bf706901dd3"

    var id: Int
    var requestType: RequestType

    init(id: Int, requestType: RequestType ) {
        self.id = id
        self.requestType = requestType
    }

    var url: String {
        let baseUrl: String = "https://api.spoonacular.com/recipes/"
        return baseUrl + String(id) + requestType.rawValue
    }

    var method: HTTPMethod {
        .get
    }

    var defaultQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

    }
    func decode(_ data: Data) throws -> DetailRecipe {
        let decoder = JSONDecoder()

        let response = try decoder.decode(DetailRecipe.self, from: data)
        return response
    }
}
