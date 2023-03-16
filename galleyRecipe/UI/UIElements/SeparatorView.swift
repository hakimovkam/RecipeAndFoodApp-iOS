//
//  Separator.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 16.03.2023.
//

import UIKit

class SeparatorView: UIView {

    init() {
        super.init(frame: .zero)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 20),
            widthAnchor.constraint(equalToConstant: 1)
        ])
    }
}
