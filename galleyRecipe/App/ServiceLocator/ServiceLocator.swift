//
//  ServiceLocator.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.03.2023.
//

import Foundation

final class ServiceLocator {

    private lazy var services: [String: Any] = [:]

    func add<T>(service: T) {
        let key = "\(T.self)"
        services[key] = service
    }

    func getService<T>() -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }

    func getAny<T>() -> T? {
        services.compactMap({ $0.value as? T }).first
    }
}

extension ServiceLocator {

    static func getService<T>() -> T? {
        for ctx in contextStack.reversed() {
            if let service: T = ctx.getService() {
                #if DEBUG
                print("Using \(service) for \(T.self) from Context #\(ctx.index)")
                #endif
                return service
            }
        }

        return nil
    }

    static func getAny<T>() -> T? {
        for ctx in contextStack.reversed() {
            if let service: T = ctx.getAny() {
                #if DEBUG
                print("Using \(service) for \(T.self) from Context #\(ctx.index)")
                #endif
                return service
            }
        }

        return nil
    }
}

extension ServiceLocator {
    private static var contextStack: [ServiceLocator] = [ServiceLocator()]

    static func begin() -> ServiceLocator {
        let locator = ServiceLocator()
        contextStack.append(locator)

        return locator
    }

    static func close() {
        _ = contextStack.popLast()
    }

    static var shared: ServiceLocator { top() }
    static func top() -> ServiceLocator {
        if let last = contextStack.last { return last }

        return begin()
    }

    static func withContext<T>(_ closure: (ServiceLocator) -> T ) -> T {
        let context = begin()
        let result = closure(context)
        close()
        return result
    }

    var index: Int { Self.contextStack.firstIndex(where: { $0 === self }) ?? -1 }
}
