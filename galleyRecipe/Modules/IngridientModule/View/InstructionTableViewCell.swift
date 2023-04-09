//
//  InstructionTableViewCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 26.03.2023.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    static let identifier = "InstructionTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        configureEmptyCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let numberLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .customGreen2
        view.layer.cornerRadius = .ingredientsCellcircleImageHeightAndWeigth / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stepDescriptionLabel: UILabel = {
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

    func configure(number: Int, stepDescription: String) {
        numberLabel.text = String(number)
        stepDescriptionLabel.text = stepDescription

        numberLabel.textColor = .white
        stepDescriptionLabel.backgroundColor = .clear
        numberView.backgroundColor = .customGreen2
//        numberView.isShimmering = false
//        stepDescriptionLabel.isShimmering = false
    }

    func configureEmptyCell() {
        numberView.backgroundColor = .customLightGray
        stepDescriptionLabel.text = .emptyString2
        stepDescriptionLabel.backgroundColor = .customLightGray

//        numberView.isShimmering = true
//        stepDescriptionLabel.isShimmering = true
    }

    override func prepareForReuse() {
        configureEmptyCell()
        super.prepareForReuse()
    }

    private func setupConstraints() {
        contentView.addSubview(numberView)
        contentView.addSubview(numberLabel)
        contentView.addSubview(stepDescriptionLabel)

        NSLayoutConstraint.activate([

            numberView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .ingredientsCellCircleImageLeadingAnchor),
            numberView.widthAnchor.constraint(equalToConstant: .ingredientsCellcircleImageHeightAndWeigth),
            numberView.heightAnchor.constraint(equalToConstant: .ingredientsCellcircleImageHeightAndWeigth),
            numberView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: numberView.heightAnchor, constant: .smallTopAndBottomInset * 2),
            numberLabel.centerXAnchor.constraint(equalTo: numberView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: numberView.centerYAnchor),

            stepDescriptionLabel.leftAnchor.constraint(equalTo: numberView.rightAnchor, constant: .ingredientsCellFoodNameLabelLeftAnchor),
            stepDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .smallTopAndBottomInset),
            contentView.bottomAnchor.constraint(equalTo: stepDescriptionLabel.bottomAnchor, constant: .smallTopAndBottomInset),
            contentView.rightAnchor.constraint(equalTo: stepDescriptionLabel.rightAnchor, constant: .ingredientViewVInset)
        ])
    }
}
