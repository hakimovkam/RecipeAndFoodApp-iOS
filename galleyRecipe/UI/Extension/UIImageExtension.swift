//
//  UIImageExtension.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 27.02.2023.
//

import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
            }
      }
}
