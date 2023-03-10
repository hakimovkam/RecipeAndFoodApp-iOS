//
//  RealmManager.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 25.02.2023.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    var mealTypeItems: Results<RealmChipsMealType>! { get set }
    var cuisineTypeItems: Results<RealmChipsCuisineType>! { get set }
    var recipes: Results<RealmFavoriteRecipe>! { get set }

    func setDefaultValueForChips()
    func getMealTypeItems() -> Results<RealmChipsMealType>
    func getCuisineTypeItems() -> Results<RealmChipsCuisineType>
    func updateCuisineType(indexPath: Int)
    func updateMealTypeItem(indexPath: Int)
    func changeFavoriteRecipeInRealm(recipe: DetailRecipe)
    func getFavoriteRecipesInRealm() -> Results<RealmFavoriteRecipe>
    func checkRecipeInRealmById(id: Int) -> Bool
    func checkCountryInRealm(country: String) -> Bool
}

final class RealmManager: RealmManagerProtocol {

    var realm: Realm = try! Realm()  // swiftlint:disable:this force_try

    init() {
        mealTypeItems = realm.objects(RealmChipsMealType.self)
        cuisineTypeItems = realm.objects(RealmChipsCuisineType.self)
        recipes = realm.objects(RealmFavoriteRecipe.self)

        setDefaultValueForChips()

        resetChips()
    }

// MARK: - favorite recipes manager
    var recipes: Results<RealmFavoriteRecipe>!

    func getFavoriteRecipesInRealm() -> Results<RealmFavoriteRecipe> { return recipes }

    func checkRecipeInRealmById(id: Int) -> Bool {
        if realm.object(ofType: RealmFavoriteRecipe.self, forPrimaryKey: id) != nil {
            return true
        }
        return false
    }

    func changeFavoriteRecipeInRealm(recipe: DetailRecipe) {
        if let obj = realm.object(ofType: RealmFavoriteRecipe.self, forPrimaryKey: recipe.id) {

            try! realm.write { // swiftlint:disable:this force_try
                realm.delete(obj)
            }
        } else {
            let realmRecipe = recipe.managedObject()
            try! realm.write { // swiftlint:disable:this force_try
                realm.add(realmRecipe)
            }
        }
    }

// MARK: - chips manager
    var mealTypeItems: Results<RealmChipsMealType>!
    var cuisineTypeItems: Results<RealmChipsCuisineType>!

    func checkCountryInRealm(country: String) -> Bool {
        let result = realm.objects(RealmChipsCuisineType.self).filter("cuisine == '\(country)'")
        print(!result.isEmpty)
        return !result.isEmpty
    }

    func getMealTypeItems() -> Results<RealmChipsMealType> { return mealTypeItems }

    func updateMealTypeItem(indexPath: Int) {
        try! realm.write {  // swiftlint:disable:this force_try
            mealTypeItems[indexPath].isSelectedCell = !mealTypeItems[indexPath].isSelectedCell
        }
    }

    func updateCuisineType(indexPath: Int) {
        try! realm.write { // swiftlint:disable:this force_try
            cuisineTypeItems[indexPath].isSelectedCell = !cuisineTypeItems[indexPath].isSelectedCell
        }
    }

    func getCuisineTypeItems() -> Results<RealmChipsCuisineType> { return cuisineTypeItems }

    func setDefaultValueForChips() {

        if mealTypeItems.count == 0 {
            try! realm.write { // swiftlint:disable:this force_try
                let defaultCategories = MealCategorys().mealTypes
                for category in defaultCategories {
                    self.realm.add(category)
                }
            }
            mealTypeItems = realm.objects(RealmChipsMealType.self)
        }

        if cuisineTypeItems.count == 0 {
            try! realm.write { // swiftlint:disable:this force_try
                let defaultCategories = MealCategorys().cusineTypes
                for category in defaultCategories {
                    self.realm.add(category)
                }
            }
            cuisineTypeItems = realm.objects(RealmChipsCuisineType.self)
        }
    }

    func resetChips() {
        try! realm.write { // swiftlint:disable:this force_try
            for item in mealTypeItems {
                item.isSelectedCell = false
            }
        }

        try! realm.write { // swiftlint:disable:this force_try
            for item in cuisineTypeItems {
                item.isSelectedCell = false
            }
        }
    }
}
