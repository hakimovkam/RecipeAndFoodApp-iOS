//
//  CollectionViewCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 02.02.2023.
//

import UIKit

final class ChipsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChipsCell"

    private let label: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = false
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.backgroundColor = .clear
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.customBorderColor.cgColor
        label.layer.cornerRadius = 16
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addView() {
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: .collectionViewCellHeigh)
        ])
    }

    func configure(with text: String, cellIsselected: Bool) {
        label.text = text

        if cellIsselected {
            label.backgroundColor = .customGreen
            label.layer.borderColor = UIColor.customGreen.cgColor
            label.textColor = .white
        } else {
            label.backgroundColor = .white
            label.layer.borderColor = UIColor.customBorderColor.cgColor
            label.textColor = .black
        }
    }
}
