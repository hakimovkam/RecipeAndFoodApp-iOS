//
//  MealCategorys.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 17.02.2023.
//

import Foundation

struct MealCategorys {
    
    static let mealTypes: [ChipsMealType] = [
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
    
    static let cusinesTypes: [ChipsCusinesType] = [
        ChipsCusinesType(value: ["African", "African", false]),
        ChipsCusinesType(value: ["American", "🇺🇸", false]),
        ChipsCusinesType(value: ["British", "🇬🇧", false]),
        ChipsCusinesType(value: ["Cajun", "Cajun", false]),
        ChipsCusinesType(value: ["Caribbean", "Caribbean", false]),
        ChipsCusinesType(value: ["Chinese", "🇨🇳", false]),
        ChipsCusinesType(value: ["Eastern European", "Eastern European", false]),
        ChipsCusinesType(value: ["European", "European", false]),
        ChipsCusinesType(value: ["French", "🇫🇷", false]),
        ChipsCusinesType(value: ["German", "🇩🇪", false]),
        ChipsCusinesType(value: ["Greek", "🇬🇷", false]),
        ChipsCusinesType(value: ["Indian", "🇮🇳", false]),
        ChipsCusinesType(value: ["Irish", "🇮🇪", false]),
        ChipsCusinesType(value: ["Italian", "🇮🇹", false]),
        ChipsCusinesType(value: ["Japanese", "🇯🇵", false]),
        ChipsCusinesType(value: ["Jewish", "🇮🇱", false]),
        ChipsCusinesType(value: ["Korean", "🇰🇷", false]),
        ChipsCusinesType(value: ["Latin American", "🇧🇷", false]),
        ChipsCusinesType(value: ["Mediterranean", "Mediterranean", false]),
        ChipsCusinesType(value: ["Mexican", "🇲🇽", false]),
        ChipsCusinesType(value: ["Middle Eastern", "Middle Eastern", false]),
        ChipsCusinesType(value: ["Nordic", "Nordic", false]),
        ChipsCusinesType(value: ["Southern", "Southern", false]),
        ChipsCusinesType(value: ["Spanish", "🇪🇸", false]),
        ChipsCusinesType(value: ["Thai", "🇹🇭", false]),
        ChipsCusinesType(value: ["Vietnamese", "🇻🇳", false])
    ]
}
