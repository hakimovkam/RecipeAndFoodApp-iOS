//
//  IngredientsViewController.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 24.01.2023.
//

import UIKit

final class IngredientsViewController: UIViewController {
    private let presenter: IngridientViewPresenterProtocol

    // MARK: - UI

    private let ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderColor = UIColor.customLightGray.cgColor
        tableView.layer.borderWidth = 1.5
        tableView.layer.cornerRadius = 20
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var gradientDark: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = imageOnTop.bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor(white: 0, alpha: 1).cgColor]
        gradient.locations = [0.4, 1]

        return gradient
    }()
    
    private lazy var gradientLight: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        gradient.locations = [0.75, 1]
        return gradient
    }()

    private let imageOnTop: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageConstant.ingredientsImageOnTop)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let viewFromBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20.0
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let ingredientDiscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TestingData.ingredientLabelText
        label.configureLabels()
        label.font = UIFont(name: "Poppins-Bold", size: 24)
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

    private lazy var numberTogle: NumberTogleView = {
        let numberTogleView = NumberTogleView()
        numberTogleView.layer.cornerRadius = 20
        numberTogleView.translatesAutoresizingMaskIntoConstraints = false

        return numberTogleView
    }()

    private let tableSwitcher: InstructionIngredientSwitch = {
        let switcher = InstructionIngredientSwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false

        return switcher
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageConstant.arrowLeft), for: .normal)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var cookItButton: UIButton = {
        let buton = UIButton()
        buton.backgroundColor = .customGreen
        buton.layer.cornerRadius = 16
        buton.setTitle("Cook it!", for: .normal)
        buton.setTitleColor(.white, for: .normal)
        buton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 20)
        buton.translatesAutoresizingMaskIntoConstraints = false

        return buton
    }()

    init(presenter: IngridientViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        setupConstraints()
        addSublabelsToStackView()

        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
        ingredientsTableView.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageOnTop.layer.addSublayer(gradientDark)
    }

    private func addSublabelsToStackView() {
        let waitingTime = UILabel()
        let servings = UILabel()
        let calories = UILabel()
        let separator = SeparatorView()
        let separator2 = SeparatorView()
        stackView.distribution = .equalCentering

        waitingTime.textColor = .white
        servings.textColor = .white
        calories.textColor = .white

        waitingTime.text = TestingData.waitingTimeText
        servings.text = TestingData.servingsText
        calories.text = TestingData.caloriesText

        stackView.addArrangedSubview(waitingTime)
        stackView.addArrangedSubview(separator)
        stackView.addArrangedSubview(servings)
        stackView.addArrangedSubview(separator2)
        stackView.addArrangedSubview(calories)
    }

    @objc
    private func tapBackButton() {
        presenter.backButtonDidPressed()
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource

 extension IngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath)
        return cell
    }
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
 }
// MARK: - ViewProtocol
extension IngredientsViewController: IngridientViewProtocol {

}

// MARK: - Constraints
extension IngredientsViewController {

    private func setupConstraints() {
        view.addSubview(imageOnTop)
        view.addSubview(viewFromBottom)
        view.addSubview(ingredientDiscriptionLabel)
        view.addSubview(stackView)
        view.addSubview(numberTogle)
        viewFromBottom.addSubview(ingredientsTableView)
        view.addSubview(backButton)
        view.addSubview(tableSwitcher)
        view.layer.addSublayer(gradientLight)
        view.addSubview(cookItButton)

        NSLayoutConstraint.activate([
            imageOnTop.topAnchor.constraint(equalTo: view.topAnchor),
            imageOnTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageOnTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageOnTop.heightAnchor.constraint(equalToConstant: .ingredientsImageOnTopHeightAnchor),

            viewFromBottom.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewFromBottom.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewFromBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageOnTop.bottomAnchor.constraint(equalTo: viewFromBottom.topAnchor, constant: .mediumAdditionalViewAnchoor),

            ingredientDiscriptionLabel.bottomAnchor.constraint(equalTo: viewFromBottom.topAnchor, constant: .ingredientsIngredientLabelAnchor),
            ingredientDiscriptionLabel.leadingAnchor.constraint(equalTo: imageOnTop.leadingAnchor, constant: .ingredientLabelTrailingAndLeadingAnchors),
            imageOnTop.trailingAnchor.constraint(equalTo: ingredientDiscriptionLabel.trailingAnchor, constant: .ingredientLabelTrailingAndLeadingAnchors),
            ingredientDiscriptionLabel.centerXAnchor.constraint(equalTo: imageOnTop.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: ingredientDiscriptionLabel.bottomAnchor, constant: .ingredientsStackViewTopAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .ingredientsStackViewTrailingAndLeadingAnchors),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: .ingredientsStackViewTrailingAndLeadingAnchors),

            numberTogle.topAnchor.constraint(equalTo: viewFromBottom.topAnchor, constant: .ingredientsGrayViewTopAnchor),
            numberTogle.heightAnchor.constraint(equalToConstant: .ingredientsGrayViewHeightAnchor),
            numberTogle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: numberTogle.rightAnchor, constant: .mediemLeftRightInset),

            tableSwitcher.topAnchor.constraint(equalTo: numberTogle.bottomAnchor, constant: .ingredientViewHInset),
            tableSwitcher.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: tableSwitcher.rightAnchor, constant: .ingredientViewVInset),
            tableSwitcher.heightAnchor.constraint(equalToConstant: .mediumHeightAnchor),

            ingredientsTableView.topAnchor.constraint(equalTo: tableSwitcher.bottomAnchor, constant: .ingredientViewHInset),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ingredientsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .ingredientViewVInset),
            view.rightAnchor.constraint(equalTo: ingredientsTableView.rightAnchor, constant: .ingredientViewVInset),

            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .ingredientsBackButtonLeftAnchor),

            cookItButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cookItButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .ingredientViewVInset),
            view.rightAnchor.constraint(equalTo: cookItButton.rightAnchor, constant: .ingredientViewVInset),
            cookItButton.heightAnchor.constraint(equalToConstant: .cookItButtonHeight)
        ])
    }
}
