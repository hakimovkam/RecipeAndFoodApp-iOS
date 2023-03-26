//
//  IngredientsTableViewCell.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 30.01.2023.
//

import UIKit
import Kingfisher

class IngredientsTableViewCell: UITableViewCell {

    static let identifier = "IngredientsTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        configureEmptyCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .customLightGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = .ingredientsCellcircleImageHeightAndWeigth / 2
        imageView.layer.borderColor = UIColor.customLightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .customLightGray
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.text = .emptyString
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var foodWeightLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .customLightGray
        label.font = UIFont(name: "Poppins-Light", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = .emptyString
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(imageUrl: String, foodName: String, foodWeight: String) {
        circleImage.kf.setImage(with: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(imageUrl)"), options: [.transition(.fade(0.3))], completionHandler: { [weak self] _ in
            guard let self = self else { return }
            self.circleImage.isShimmering = false
        })

        var foodWeightString = foodWeight
        if !foodWeightString.isEmpty && foodWeightString.last == ")" {
            foodWeightString.remove(at: foodWeightString.index(before: foodWeightString.endIndex))
        }
        foodNameLabel.text = foodName
        foodWeightLabel.text = foodWeightString

        foodWeightLabel.backgroundColor = .clear
        foodWeightLabel.isShimmering = false
        foodNameLabel.backgroundColor = .clear
        foodNameLabel.isShimmering = false
    }

    func configureEmptyCell() {
        circleImage.image = UIImage()
        circleImage.backgroundColor = .customLightGray
        foodNameLabel.text = .emptyString2
        foodWeightLabel.text = .emptyString
        foodNameLabel.backgroundColor = .customLightGray
        foodWeightLabel.backgroundColor = .customLightGray
        
        circleImage.isShimmering = true
        foodNameLabel.isShimmering = true
        foodWeightLabel.isShimmering = true
    }

    override func prepareForReuse() {
        configureEmptyCell()
        super.prepareForReuse()
    }

    private func setupConstraints() {
        contentView.addSubview(circleImage)
        contentView.addSubview(foodNameLabel)
        contentView.addSubview(foodWeightLabel)
        
        NSLayoutConstraint.activate([

            circleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .ingredientsCellCircleImageLeadingAnchor),
            circleImage.widthAnchor.constraint(equalToConstant: .ingredientsCellcircleImageHeightAndWeigth),
            circleImage.heightAnchor.constraint(equalToConstant: .ingredientsCellcircleImageHeightAndWeigth),
            circleImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: circleImage.heightAnchor, constant: .smallTopAndBottomInset * 2),

            foodNameLabel.leftAnchor.constraint(equalTo: circleImage.rightAnchor, constant: .ingredientsCellFoodNameLabelLeftAnchor),
            foodNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .smallTopAndBottomInset),
            contentView.bottomAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: .smallTopAndBottomInset),
            foodWeightLabel.leftAnchor.constraint(equalTo: foodNameLabel.rightAnchor, constant: .ingredientViewVInset),

            foodWeightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.rightAnchor.constraint(equalTo: foodWeightLabel.rightAnchor, constant: .ingredientsCellFoodWeightLabelLeftAnchor)
        ])
    }
}
