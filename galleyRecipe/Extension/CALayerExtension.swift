//
//  CALayerExtension.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 27.02.2023.
//

import UIKit

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat, offset: CGFloat = 0) {

        let border = CALayer()

        switch edge {
            // swiftlint:disable all
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: offset, y: self.frame.height - thickness, width: UIScreen.main.bounds.width -  offset * 2, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
            // swiftlint:enable all
        }
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
