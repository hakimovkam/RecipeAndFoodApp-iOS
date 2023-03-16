//
//  TimerListCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.01.2023.
//

import UIKit

class TimerListCell: UITableViewCell {

    static let identifier = "TimerListCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var foodImage: UIImageView = {
        let image = UIImage(named: ImageConstant.noImage)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    var timerLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = false
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.customBorderColor.cgColor
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.text = "10:33"
        label.font = UIFont(name: "Poppins-Bold", size: 14)
        label.textColor = .customGreen
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    func configure(foodImageName: String, timer: String, descriptionLabelText: String) {
        foodImage.image = UIImage(named: foodImageName)
        timerLabel.text =  timer
        descriptionLabel.text = descriptionLabelText
    }
}

extension TimerListCell {

    func setupViews() {
        contentView.addSubview(foodImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(timerLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImage.heightAnchor.constraint(equalToConstant: .smallFoodImageWidthHeighAnchoor),
            foodImage.widthAnchor.constraint(equalToConstant: .smallFoodImageWidthHeighAnchoor),
            foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .smallImageLeftRightAnchor),

            descriptionLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: .mediemLeftRightInset),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .smallTopAndBottomInset),
            contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .smallTopAndBottomInset),
            timerLabel.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: .mediemLeftRightInset),

            contentView.rightAnchor.constraint(equalTo: timerLabel.rightAnchor, constant: .smallImageLeftRightAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            timerLabel.widthAnchor.constraint(equalToConstant: .timerLabelWidthAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: .mediumHeightAnchor)
        ])
    }
}
