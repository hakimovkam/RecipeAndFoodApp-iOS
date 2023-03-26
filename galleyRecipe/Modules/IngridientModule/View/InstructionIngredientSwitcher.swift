//
//  InstructionIngredientSwitcher.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 16.03.2023.
//

import UIKit

final class InstructionIngredientSwitch: UIView {

    private var ingredientIsSelected: Bool = false
    var ingredientTapCallback: (() -> Void) = {}
    var instructionTapCallback: (() -> Void) = {}

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
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 20)
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
        ingredientTapCallback()
        toggle()
    }

    @objc
    func instructionButtonDidPressed() {
        ingredientIsSelected = false
        instructionTapCallback()
        toggle()
    }

    func configure(ingredientButton: @escaping (() -> Void),
                   instructionButton: @escaping (() -> Void)) {
        instructionTapCallback = instructionButton
        ingredientTapCallback = ingredientButton
    }

    private func toggle() {
        if ingredientIsSelected {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: UIView.AnimationOptions.curveEaseOut
            ) {
                self.ingredientsButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.ingredientsButton.setTitleColor(.black, for: .normal)

                self.instructionButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.instructionButton.setTitleColor(.customGray, for: .normal)
            }
        } else {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: UIView.AnimationOptions.curveEaseOut
            ) {
                self.ingredientsButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.ingredientsButton.setTitleColor(.customGray, for: .normal)

                self.instructionButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.instructionButton.setTitleColor(.black, for: .normal)
            }
        }
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
