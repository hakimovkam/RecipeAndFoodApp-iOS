//
//  RealmManager.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 25.02.2023.
//

import Foundation
import RealmSwift

protocol RealManagerProtocol {
    var mealTypeItems: Results<ChipsMealType>! { get set }
    var cuisineTypeItems: Results<ChipsCuisineType>! { get set }
    func setDefaultValueForChips()
    func getMealTypeItems() -> Results<ChipsMealType>
    func getCuisineTypeItems() -> Results<ChipsCuisineType>
    func updateCuisineType(indexPath: Int)
    func updateMealTypeItem(indexPath: Int)
}

final class RealmManager: RealManagerProtocol {

    private let realm = try! Realm()  // swiftlint:disable:this force_try

    var mealTypeItems: Results<ChipsMealType>!
    var cuisineTypeItems: Results<ChipsCuisineType>!

    init() {
        mealTypeItems = realm.objects(ChipsMealType.self)
        cuisineTypeItems = realm.objects(ChipsCuisineType.self)

        setDefaultValueForChips()
        resetChips()
    }

    func getMealTypeItems() -> Results<ChipsMealType> {
        return mealTypeItems
    }

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

    func getCuisineTypeItems() -> Results<ChipsCuisineType> {
        return cuisineTypeItems
    }

    func setDefaultValueForChips() {

        if mealTypeItems.count == 0 {
            try! realm.write { // swiftlint:disable:this force_try
                let defaultCategories = MealCategorys().mealTypes
                for category in defaultCategories {
                    self.realm.add(category)
                }
            }
            mealTypeItems = realm.objects(ChipsMealType.self)
        }

        if cuisineTypeItems.count == 0 {
            try! realm.write { // swiftlint:disable:this force_try
                let defaultCategories = MealCategorys().cusineTypes
                for category in defaultCategories {
                    self.realm.add(category)
                }
            }
            cuisineTypeItems = realm.objects(ChipsCuisineType.self)
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
