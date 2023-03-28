//
//  ChipsModel.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 24.02.2023.
//

import Foundation
import RealmSwift

class RealmChipsMealType: Object {
    @objc dynamic var mealType = ""
    @objc dynamic var isSelectedCell = false
}

class RealmChipsCuisineType: Object {
    @objc dynamic var cuisine = ""
    @objc dynamic var cuisineFlag = ""
    @objc dynamic var isSelectedCell = false
}
