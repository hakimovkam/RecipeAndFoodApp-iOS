//
//  InstructionIngredientSwitcher.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 16.03.2023.
//

import UIKit

final class InstructionIngredientSwitch: UIView {

    private var ingredientIsSelected: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(instructionView)
        addSubview(ingredientView)
        addSubview(instructionButton)
        addSubview(ingredientsButton)
        addSubview(separator)

        separator.backgroundColor = .customGray
        setConstraint()
        toggle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var ingredientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var instructionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var ingredientsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        button.setTitleColor(.customGray, for: .normal)
        button.setTitle("Ingredients", for: .normal)
        button.addTarget(self, action: #selector(ingredientButtonDidPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var instructionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Instruction", for: .normal)
        button.addTarget(self, action: #selector(instructionButtonDidPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var separator = SeparatorView()

    @objc
    func ingredientButtonDidPressed() {
        ingredientIsSelected = true
        toggle()
    }

    @objc
    func instructionButtonDidPressed() {
        ingredientIsSelected = false
        toggle()
    }

    func toggle() {
        if ingredientIsSelected {
            ingredientsButton.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 20)
            ingredientsButton.setTitleColor(.black, for: .normal)

            instructionButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
            instructionButton.setTitleColor(.customGray, for: .normal)
        } else {
            instructionButton.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 20)
            instructionButton.setTitleColor(.black, for: .normal)

            ingredientsButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
            ingredientsButton.setTitleColor(.customGray, for: .normal)
        }
    }

    func configure() {

    }
}

extension InstructionIngredientSwitch {
    func setConstraint() {
        NSLayoutConstraint.activate([
            separator.centerXAnchor.constraint(equalTo: centerXAnchor),
            separator.centerYAnchor.constraint(equalTo: centerYAnchor),

            instructionView.leftAnchor.constraint(equalTo: leftAnchor),
            instructionView.rightAnchor.constraint(equalTo: centerXAnchor),
            instructionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            ingredientView.leftAnchor.constraint(equalTo: centerXAnchor),
            ingredientView.rightAnchor.constraint(equalTo: rightAnchor),
            ingredientView.bottomAnchor.constraint(equalTo: bottomAnchor),

            ingredientsButton.centerXAnchor.constraint(equalTo: ingredientView.centerXAnchor),
            ingredientsButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            instructionButton.centerXAnchor.constraint(equalTo: instructionView.centerXAnchor),
            instructionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
