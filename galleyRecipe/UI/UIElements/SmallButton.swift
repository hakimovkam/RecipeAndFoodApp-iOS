//
//  SmallButton.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 09.03.2023.
//

import UIKit

class SmallButon: UIButton {

    static let offset: CGFloat  = -10

    let touchAreaInsets = UIEdgeInsets(top: SmallButon.offset, left: SmallButon.offset, bottom: SmallButon.offset, right: SmallButon.offset)

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let hitFrame = bounds.inset(by: touchAreaInsets)
        return hitFrame.contains(point)
    }
}
