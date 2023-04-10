//
//  RealmManager.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 25.02.2023.
//

import Foundation
import RealmSwift

enum RealmCRUDAction {
    case fromTimer
    case fromFavorite
}

protocol RealmManagerProtocol {
    var mealTypeItems: Results<RealmChipsMealType>! { get set }
    var cuisineTypeItems: Results<RealmChipsCuisineType>! { get set }
    var recipes: Results<RealmRecipe>! { get set }

    func setDefaultValueForChips()
    func getMealTypeItems() -> Results<RealmChipsMealType>
    func getCuisineTypeItems() -> Results<RealmChipsCuisineType>
    func updateCuisineType(indexPath: Int)
    func updateMealTypeItem(indexPath: Int)
    func changeFavoriteRecipeInRealm(recipe: DetailRecipe, action: RealmCRUDAction)
    func getFavoriteRecipesInRealm() -> Results<RealmRecipe>
    func checkFavoriteRecipeInRealmById(id: Int) -> Bool
    func checkCountryInRealm(country: String) -> Bool
    func getRecipeByIdFromRealm(id: Int) -> DetailRecipe?
    func updateRecipeInfo(servings: Int, calorie: Double, id: Int)
}

final class RealmManager: RealmManagerProtocol {

    var realm: Realm = try! Realm()  // swiftlint:disable:this force_try

    init() {
        mealTypeItems = realm.objects(RealmChipsMealType.self)
        cuisineTypeItems = realm.objects(RealmChipsCuisineType.self)
        recipes = realm.objects(RealmRecipe.self)

        setDefaultValueForChips()

        resetChips()
    }

// MARK: - favorite recipes manager
    var recipes: Results<RealmRecipe>!

    func getFavoriteRecipesInRealm() -> Results<RealmRecipe> { return recipes }

    func getRecipeByIdFromRealm(id: Int) -> DetailRecipe? {
        if let recipe = recipes.filter("id == \(id)").first {
            return DetailRecipe(managedObject: recipe)
        } else {
            return nil
        }
    }

    func checkFavoriteRecipeInRealmById(id: Int) -> Bool {
        if let recipe = realm.object(ofType: RealmRecipe.self, forPrimaryKey: id) {
            return recipe.status
        }
        return false
    }

    func changeFavoriteRecipeInRealm(recipe: DetailRecipe, action: RealmCRUDAction) {

        if let obj = realm.object(ofType: RealmRecipe.self, forPrimaryKey: recipe.id) {

            try! realm.write { // swiftlint:disable:this force_try
                if action == .fromFavorite {
                    obj.status = !obj.status
                } else if action == .fromTimer {
                    obj.timerStatus = !obj.timerStatus
                }

                if obj.status == false && obj.timerStatus == false {
                    realm.delete(obj)
                }
            }
        } else {
            let realmRecipe = recipe.managedObject()
            try! realm.write { // swiftlint:disable:this force_try
                realm.add(realmRecipe)
                if action == .fromFavorite {
                    realmRecipe.status = true
                } else if action == .fromTimer {
                    realmRecipe.timerStatus = true
                }
            }
        }
    }

    func updateRecipeInfo(servings: Int, calorie: Double, id: Int) {
        guard let realm = try? Realm() else {
            return
        }

        realm.beginWrite()

        if let recipe = realm.object(ofType: RealmRecipe.self, forPrimaryKey: id) {
            recipe.servings = servings
            recipe.nutrition.nutrients[0].amount = calorie
        }

        try? realm.commitWrite()
    }

// MARK: - chips manager
    var mealTypeItems: Results<RealmChipsMealType>!
    var cuisineTypeItems: Results<RealmChipsCuisineType>!

    func checkCountryInRealm(country: String) -> Bool {
        let result = realm.objects(RealmChipsCuisineType.self).filter("cuisine == '\(country)'")
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
