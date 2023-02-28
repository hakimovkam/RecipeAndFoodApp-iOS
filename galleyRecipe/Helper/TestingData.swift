//
//  TestingData.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 09.02.2023.
//

import Foundation

struct TestingData {
    var data = ["Pasta", "q", "Pasta", "3", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta",
                "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta",
                "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta", "Pasta"]

    var nameCategoryArray = ["Soup", "Pasta", "Egg", "Apple", "Orange", "Soup", "Pasta", "Egg", "Apple", "Orange", "Soup", "Pasta", "Egg", "Apple", "Orange"]

    var countryCategoryArray = ["🏴", "🇦🇱", "🏴‍☠️", "🏁", "🏴", "🇦🇱", "🏴‍☠️", "🏁", "🏴", "🇦🇱", "🏴‍☠️", "🏁"]
    var emptyData: [String] = []
    var recipeDescription: String = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
    var timer: String = "10:33"

    static let ingredientLabelText = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
    static let ingredientsButtonText = "Ingredients"
    static let instructionsButtonText = "Instructions"
    static let waitingTimeText = "15 min"
    static let servingsText = "2 servings"
    static let caloriesText = "250 calories"
    static let circleImageText = "Pasta"
    static let foodNameLabel = "Pasta"
    static let foodWeightLabel = "400 g"
}
