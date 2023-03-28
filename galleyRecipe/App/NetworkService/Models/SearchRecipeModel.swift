//
//  SearchRecipeModel.swift
//  galleyRecipe
//
//  Created by garpun on 28.01.2023.
//

import Foundation

struct SearchRecipeModel: Decodable {
    let offset: Int
    let number: Int
    let totalResults: Int
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
