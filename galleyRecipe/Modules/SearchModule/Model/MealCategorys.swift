//
//  MealCategorys.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 17.02.2023.
//

import Foundation

struct MealCategorys {

    let mealTypes: [RealmChipsMealType] = [
        RealmChipsMealType(value: ["main course", false] as [Any]),
        RealmChipsMealType(value: ["side dish", false] as [Any]),
        RealmChipsMealType(value: ["dessert", false] as [Any]),
        RealmChipsMealType(value: ["appetizer", false] as [Any]),
        RealmChipsMealType(value: ["salad", false] as [Any]),
        RealmChipsMealType(value: ["bread", false] as [Any]),
        RealmChipsMealType(value: ["breakfast", false] as [Any]),
        RealmChipsMealType(value: ["soup", false] as [Any]),
        RealmChipsMealType(value: ["beverage", false] as [Any]),
        RealmChipsMealType(value: ["sauce", false] as [Any]),
        RealmChipsMealType(value: ["marinade", false] as [Any]),
        RealmChipsMealType(value: ["fingerfood", false] as [Any]),
        RealmChipsMealType(value: ["snack", false] as [Any]),
        RealmChipsMealType(value: ["drink", false] as [Any])
    ]

    let cusineTypes: [RealmChipsCuisineType] = [
        RealmChipsCuisineType(value: ["African", "African", false] as [Any]),
        RealmChipsCuisineType(value: ["American", "🇺🇸", false] as [Any]),
        RealmChipsCuisineType(value: ["British", "🇬🇧", false] as [Any]),
        RealmChipsCuisineType(value: ["Cajun", "Cajun", false] as [Any]),
        RealmChipsCuisineType(value: ["Caribbean", "Caribbean", false] as [Any]),
        RealmChipsCuisineType(value: ["Chinese", "🇨🇳", false] as [Any]),
        RealmChipsCuisineType(value: ["Eastern European", "Eastern European", false] as [Any]),
        RealmChipsCuisineType(value: ["European", "European", false] as [Any]),
        RealmChipsCuisineType(value: ["French", "🇫🇷", false] as [Any]),
        RealmChipsCuisineType(value: ["German", "🇩🇪", false] as [Any]),
        RealmChipsCuisineType(value: ["Greek", "🇬🇷", false] as [Any]),
        RealmChipsCuisineType(value: ["Indian", "🇮🇳", false] as [Any]),
        RealmChipsCuisineType(value: ["Irish", "🇮🇪", false] as [Any]),
        RealmChipsCuisineType(value: ["Italian", "🇮🇹", false] as [Any]),
        RealmChipsCuisineType(value: ["Japanese", "🇯🇵", false] as [Any]),
        RealmChipsCuisineType(value: ["Jewish", "🇮🇱", false] as [Any]),
        RealmChipsCuisineType(value: ["Korean", "🇰🇷", false] as [Any]),
        RealmChipsCuisineType(value: ["Latin American", "🇧🇷", false] as [Any]),
        RealmChipsCuisineType(value: ["Mediterranean", "Mediterranean", false] as [Any]),
        RealmChipsCuisineType(value: ["Mexican", "🇲🇽", false] as [Any]),
        RealmChipsCuisineType(value: ["Middle Eastern", "Middle Eastern", false] as [Any]),
        RealmChipsCuisineType(value: ["Nordic", "Nordic", false] as [Any]),
        RealmChipsCuisineType(value: ["Southern", "Southern", false] as [Any]),
        RealmChipsCuisineType(value: ["Spanish", "🇪🇸", false] as [Any]),
        RealmChipsCuisineType(value: ["Thai", "🇹🇭", false] as [Any]),
        RealmChipsCuisineType(value: ["Vietnamese", "🇻🇳", false] as [Any])
    ]
}
