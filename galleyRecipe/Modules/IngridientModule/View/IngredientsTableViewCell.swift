//
//  IngredientsTableViewCell.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 30.01.2023.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell {

    static let identifier = "idOptionalTableViewCell"

    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: TestingData.circleImageText)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let foodNameLabel: UILabel = {
        let label = UILabel()
        label.text = TestingData.foodNameLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let foodWeightLabel: UILabel = {
        let label = UILabel()
        label.text = TestingData.foodNameLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        self.addSubview(circleImage)
        NSLayoutConstraint.activate([
            circleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .ingredientsCellCircleImageLeadingAnchor),
            circleImage.widthAnchor.constraint(equalToConstant: .ingredientsCellcircleImageHeightAndWeigth),
            circleImage.heightAnchor.constraint(equalToConstant: .ingredientsCellcircleImageHeightAndWeigth)
        ])

        self.addSubview(foodNameLabel)
        NSLayoutConstraint.activate([
            foodNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            foodNameLabel.leftAnchor.constraint(equalTo: circleImage.rightAnchor, constant: .ingredientsCellFoodNameLabelLeftAnchor)
        ])

        self.addSubview(foodWeightLabel)
        NSLayoutConstraint.activate([
            foodWeightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.rightAnchor.constraint(equalTo: foodWeightLabel.rightAnchor, constant: .ingredientsCellFoodWeightLabelLeftAnchor)
        ])
    }
}
