//
//  Lazywired.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.03.2023.
//

import Foundation

@propertyWrapper
struct Lazywired<T> {
    init(context: ServiceLocator = .top()) {
        self.context = context
    }

    private let context: ServiceLocator

    private(set) lazy var wrappedValue: T = {
        if T.self is ExpressibleByNilLiteral.Type {
            // swiftlint:disable force_cast
            let value: T! = context.getAny()
            return value ?? (Optional<Any>.none as! T)
            // swiftlint:enable force_cast
        } else if let value: T = context.getService() {
            return value
        } else if let value: T = context.getAny() {
            return value
        } else {
            return Autowired<T>().wrappedValue
        }
    }()
}
