//
//  SearchRecipeRequest.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 19.02.2023.
//

import Foundation

struct SearchRecipeRequest: DataRequest {

    private let includeNutrition = "true"
//    private let apiKey: String = "997ced0c82834e24a3a3290f8123f2b5"
    private let apiKey: String = "6e58539408dd4110bba09bf706901dd3"

    var requestType: RequestType
    var queryItems: [URLQueryItem]

    init(requestType: RequestType, queryItems: [URLQueryItem]) {
        self.requestType = requestType
        self.queryItems = queryItems
    }

    var url: String {
        let baseUrl: String = "https://api.spoonacular.com/recipes/"
        return baseUrl + requestType.rawValue
    }

    var method: HTTPMethod {
        .get
    }

    var defaultQueryItems: [URLQueryItem] {
            [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "includeNutrition", value: includeNutrition)
            ] + queryItems
        }

    func decode(_ data: Data) throws -> SearchRecipeModel {
        let decoder = JSONDecoder()

        let response = try decoder.decode(SearchRecipeModel.self, from: data)
        return response
    }
}
