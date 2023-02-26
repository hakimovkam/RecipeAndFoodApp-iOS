//
//  IngredientsViewController.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 24.01.2023.
//

import UIKit

final class IngredientsViewController: UIViewController {

    // MARK: - UI

    private let ingredientsTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let imageOnTop: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imageOnTop")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let viewFromBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        label.configureLabels()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 24)
        label.shadowOffset = CGSize(width: 20, height: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1
        return stackView
    }()

    private let grayView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let ingredientsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ingredients", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let instructionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Instructions", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let backbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowLeft.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        addSublabelsToStackView()

        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: idOptionalTableViewCell)
        ingredientsTableView.backgroundColor = .white
    }

    private func addSublabelsToStackView() {
        let waitingTime = UILabel()
        let servings = UILabel()
        let calories = UILabel()

        waitingTime.configureLabels()
        servings.configureLabels()
        calories.configureLabels()

        waitingTime.text = "15 min"
        servings.text = "2 servings"
        calories.text = "250 calories"
        stackView.addArrangedSubview(waitingTime)
        stackView.addArrangedSubview(servings)
        stackView.addArrangedSubview(calories)
    }
}

// MARK: - Extensions
extension UILabel {
    func configureLabels() {
        self.textColor = .white
    }
}

// MARK: - Constraints
extension IngredientsViewController {

    private func setupConstraints() { // swiftlint:disable:this function_body_length
        view.addSubview(imageOnTop)         NSLayoutConstraint.activate([
            imageOnTop.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageOnTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageOnTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageOnTop.heightAnchor.constraint(equalToConstant: 300)
        ])

        view.addSubview(viewFromBottom)
        NSLayoutConstraint.activate([
            viewFromBottom.topAnchor.constraint(equalTo: imageOnTop.bottomAnchor),
            viewFromBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            viewFromBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            viewFromBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])

        imageOnTop.addSubview(ingredientLabel)
        NSLayoutConstraint.activate([
            ingredientLabel.bottomAnchor.constraint(equalTo: imageOnTop.bottomAnchor, constant: -40),
            ingredientLabel.leadingAnchor.constraint(equalTo: imageOnTop.leadingAnchor, constant: 10),
            imageOnTop.trailingAnchor.constraint(equalTo: ingredientLabel.trailingAnchor, constant: 10),
            ingredientLabel.centerXAnchor.constraint(equalTo: imageOnTop.centerXAnchor)
        ])

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: ingredientLabel.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])

        viewFromBottom.addSubview(grayView)
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: viewFromBottom.topAnchor, constant: 20),
            grayView.leadingAnchor.constraint(equalTo: viewFromBottom.leadingAnchor, constant: 15),
            viewFromBottom.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: 15),
            grayView.heightAnchor.constraint(equalToConstant: 100)
        ])

        viewFromBottom.addSubview(ingredientsButton)
        NSLayoutConstraint.activate([
            ingredientsButton.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 10),
            ingredientsButton.leadingAnchor.constraint(equalTo: viewFromBottom.leadingAnchor, constant: 50)
        ])

        viewFromBottom.addSubview(instructionsButton)
        NSLayoutConstraint.activate([
            instructionsButton.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 10),
            viewFromBottom.trailingAnchor.constraint(equalTo: instructionsButton.trailingAnchor, constant: 50)
        ])

        viewFromBottom.addSubview(ingredientsTableView)
        NSLayoutConstraint.activate([
            ingredientsTableView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 55),
            ingredientsTableView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 2),
            grayView.trailingAnchor.constraint(equalTo: ingredientsTableView.trailingAnchor, constant: 2),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])

        view.addSubview(backbutton)
        NSLayoutConstraint.activate([
            backbutton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backbutton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension IngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionalTableViewCell, for: indexPath)
        return cell
    }
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
