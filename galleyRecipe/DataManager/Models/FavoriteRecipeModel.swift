//
//  FavoriteRecipeModel.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 27.02.2023.
//

import Foundation
import RealmSwift

class FavoriteRecipe: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var readyInMinutes = 0
    @objc dynamic var servings = 0
}
