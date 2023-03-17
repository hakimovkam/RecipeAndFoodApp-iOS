//
//  NumberTogleView.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 12.03.2023.
//

import UIKit

final class NumberTogleView: UIView {

    private var servings = 1

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(number)
        backgroundColor = .customLightGray

        setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 48)
        button.setTitleColor(.customGray, for: .normal)
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(minusButtonDidPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 48)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(plusButtonDidPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var number: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 48)
        label.textAlignment = .center
        label.text = "\(servings)"
        label.textColor = .customGreen2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    func configure(servings: Int) {
        number.text = "\(servings)"
    }

    @objc
    func plusButtonDidPressed() {
        servings += 1
        if servings == 1 {
            number.text = "\(servings)"
            minusButton.setTitleColor(.customGray, for: .normal)
        } else {
            number.text = "\(servings)"
            minusButton.setTitleColor(.black, for: .normal)
        }
    }

    @objc
    func minusButtonDidPressed() {
        if servings != 1 {
            servings -= 1
            if servings == 1 {
                number.text = "\(servings)"
                minusButton.setTitleColor(.customGray, for: .normal)
            } else {
                number.text = "\(servings)"
                minusButton.setTitleColor(.black, for: .normal)
            }
        }
    }
}

extension NumberTogleView {
    func setConstraint() {
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: centerXAnchor),
            number.centerYAnchor.constraint(equalTo: centerYAnchor),

            rightAnchor.constraint(equalTo: plusButton.rightAnchor, constant: .numberTogleViewConstraint),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: .numberTogleViewConstraint)
        ])
    }

}
