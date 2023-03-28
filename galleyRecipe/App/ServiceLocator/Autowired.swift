//
//  Autowired.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.03.2023.
//

import Foundation

@propertyWrapper
struct Autowired<T> {

    let wrappedValue: T = {
        if T.self is ExpressibleByNilLiteral.Type {
            // swiftlint:disable force_cast
            let value: T! = ServiceLocator.getAny()
            return value ?? (Optional<Any>.none as! T)
            // swiftlint:enable force_cast
        } else if let value: T = ServiceLocator.getService() {
            return value
        } else if let value: T = ServiceLocator.getAny() {
            return value
        } else {
            fatalError("Service \(T.self) is not registered")
        }
    }()
}
