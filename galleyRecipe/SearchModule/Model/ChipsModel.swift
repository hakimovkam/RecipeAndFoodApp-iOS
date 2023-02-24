//
//  ChipsModel.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 24.02.2023.
//

import Foundation
import RealmSwift

class ChipsMealType: Object {
    @objc dynamic var mealType = ""
    @objc dynamic var isSelectedCell = false
}

class ChipsCusinesType: Object {
    @objc dynamic var cisines = ""
    @objc dynamic var cusinesFlag = ""
    @objc dynamic var isSelectedCell = false
}
