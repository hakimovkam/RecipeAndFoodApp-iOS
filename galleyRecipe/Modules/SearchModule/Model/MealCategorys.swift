//
//  MealCategorys.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 17.02.2023.
//

import Foundation

struct MealCategorys {

    let mealTypes: [RealmChipsMealType] = [
        RealmChipsMealType(value: ["main course", false]),
        RealmChipsMealType(value: ["side dish", false]),
        RealmChipsMealType(value: ["dessert", false]),
        RealmChipsMealType(value: ["appetizer", false]),
        RealmChipsMealType(value: ["salad", false]),
        RealmChipsMealType(value: ["bread", false]),
        RealmChipsMealType(value: ["breakfast", false]),
        RealmChipsMealType(value: ["soup", false]),
        RealmChipsMealType(value: ["beverage", false]),
        RealmChipsMealType(value: ["sauce", false]),
        RealmChipsMealType(value: ["marinade", false]),
        RealmChipsMealType(value: ["fingerfood", false]),
        RealmChipsMealType(value: ["snack", false]),
        RealmChipsMealType(value: ["drink", false])
    ]

    let cusineTypes: [RealmChipsCuisineType] = [
        RealmChipsCuisineType(value: ["African", "African", false]),
        RealmChipsCuisineType(value: ["American", "🇺🇸", false]),
        RealmChipsCuisineType(value: ["British", "🇬🇧", false]),
        RealmChipsCuisineType(value: ["Cajun", "Cajun", false]),
        RealmChipsCuisineType(value: ["Caribbean", "Caribbean", false]),
        RealmChipsCuisineType(value: ["Chinese", "🇨🇳", false]),
        RealmChipsCuisineType(value: ["Eastern European", "Eastern European", false]),
        RealmChipsCuisineType(value: ["European", "European", false]),
        RealmChipsCuisineType(value: ["French", "🇫🇷", false]),
        RealmChipsCuisineType(value: ["German", "🇩🇪", false]),
        RealmChipsCuisineType(value: ["Greek", "🇬🇷", false]),
        RealmChipsCuisineType(value: ["Indian", "🇮🇳", false]),
        RealmChipsCuisineType(value: ["Irish", "🇮🇪", false]),
        RealmChipsCuisineType(value: ["Italian", "🇮🇹", false]),
        RealmChipsCuisineType(value: ["Japanese", "🇯🇵", false]),
        RealmChipsCuisineType(value: ["Jewish", "🇮🇱", false]),
        RealmChipsCuisineType(value: ["Korean", "🇰🇷", false]),
        RealmChipsCuisineType(value: ["Latin American", "🇧🇷", false]),
        RealmChipsCuisineType(value: ["Mediterranean", "Mediterranean", false]),
        RealmChipsCuisineType(value: ["Mexican", "🇲🇽", false]),
        RealmChipsCuisineType(value: ["Middle Eastern", "Middle Eastern", false]),
        RealmChipsCuisineType(value: ["Nordic", "Nordic", false]),
        RealmChipsCuisineType(value: ["Southern", "Southern", false]),
        RealmChipsCuisineType(value: ["Spanish", "🇪🇸", false]),
        RealmChipsCuisineType(value: ["Thai", "🇹🇭", false]),
        RealmChipsCuisineType(value: ["Vietnamese", "🇻🇳", false])
    ]
}
