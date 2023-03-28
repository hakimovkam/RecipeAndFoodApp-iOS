//
//  ObjectAdapterProtocol.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 03.03.2023.
//

import Foundation
import RealmSwift

public protocol ObjectAdapterProtocol {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
