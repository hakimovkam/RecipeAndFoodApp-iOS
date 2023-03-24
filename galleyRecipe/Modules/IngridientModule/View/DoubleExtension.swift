//
//  DoubleExtension.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 19.03.2023.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
