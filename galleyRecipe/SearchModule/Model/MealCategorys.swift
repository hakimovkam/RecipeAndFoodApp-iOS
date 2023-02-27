//
//  MealCategorys.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 17.02.2023.
//

import Foundation

struct MealCategorys {

    let mealTypes: [ChipsMealType] = [
        ChipsMealType(value: ["main course", false]),
        ChipsMealType(value: ["side dish", false]),
        ChipsMealType(value: ["dessert", false]),
        ChipsMealType(value: ["appetizer", false]),
        ChipsMealType(value: ["salad", false]),
        ChipsMealType(value: ["bread", false]),
        ChipsMealType(value: ["breakfast", false]),
        ChipsMealType(value: ["soup", false]),
        ChipsMealType(value: ["beverage", false]),
        ChipsMealType(value: ["sauce", false]),
        ChipsMealType(value: ["marinade", false]),
        ChipsMealType(value: ["fingerfood", false]),
        ChipsMealType(value: ["snack", false]),
        ChipsMealType(value: ["drink", false])
    ]

    let cusineTypes: [ChipsCuisineType] = [
        ChipsCuisineType(value: ["African", "African", false]),
        ChipsCuisineType(value: ["American", "🇺🇸", false]),
        ChipsCuisineType(value: ["British", "🇬🇧", false]),
        ChipsCuisineType(value: ["Cajun", "Cajun", false]),
        ChipsCuisineType(value: ["Caribbean", "Caribbean", false]),
        ChipsCuisineType(value: ["Chinese", "🇨🇳", false]),
        ChipsCuisineType(value: ["Eastern European", "Eastern European", false]),
        ChipsCuisineType(value: ["European", "European", false]),
        ChipsCuisineType(value: ["French", "🇫🇷", false]),
        ChipsCuisineType(value: ["German", "🇩🇪", false]),
        ChipsCuisineType(value: ["Greek", "🇬🇷", false]),
        ChipsCuisineType(value: ["Indian", "🇮🇳", false]),
        ChipsCuisineType(value: ["Irish", "🇮🇪", false]),
        ChipsCuisineType(value: ["Italian", "🇮🇹", false]),
        ChipsCuisineType(value: ["Japanese", "🇯🇵", false]),
        ChipsCuisineType(value: ["Jewish", "🇮🇱", false]),
        ChipsCuisineType(value: ["Korean", "🇰🇷", false]),
        ChipsCuisineType(value: ["Latin American", "🇧🇷", false]),
        ChipsCuisineType(value: ["Mediterranean", "Mediterranean", false]),
        ChipsCuisineType(value: ["Mexican", "🇲🇽", false]),
        ChipsCuisineType(value: ["Middle Eastern", "Middle Eastern", false]),
        ChipsCuisineType(value: ["Nordic", "Nordic", false]),
        ChipsCuisineType(value: ["Southern", "Southern", false]),
        ChipsCuisineType(value: ["Spanish", "🇪🇸", false]),
        ChipsCuisineType(value: ["Thai", "🇹🇭", false]),
        ChipsCuisineType(value: ["Vietnamese", "🇻🇳", false])
    ]
}
