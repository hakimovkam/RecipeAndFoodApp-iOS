//
//  IngredientsViewController.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 24.01.2023.
//

import UIKit

final class IngredientsViewController: UIViewController {
    private let presenter: IngridientViewPresenterProtocol
    private var tableViewToggle: Bool = false
    private var showEmptyTable = true

    // MARK: - UI

    private var readyInMinutes = 0
    private var servings = 0
    private var cal: Double?

    private lazy var cycleBlurView1 = makeBlurCycle()
    private lazy var cycleBlurView2 = makeBlurCycle()

    private let recipeInfoView: RecipeInfoView = {
        let view = RecipeInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderColor = UIColor.customLightGray.cgColor
        tableView.layer.borderWidth = 1.5
        tableView.layer.cornerRadius = 20
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset.bottom = .cookItButtonHeight + .mediemLeftRightInset

        return tableView
    }()

    private lazy var gradientDark: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = imageOnTop.bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor(white: 0, alpha: 1).cgColor]
        gradient.locations = [0.4, 1]
        gradient.isHidden = true

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
        imageView.backgroundColor = .customLightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
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
        label.configureLabels()
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.shadowOffset = CGSize(width: 20, height: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let numberTogle: NumberTogleView = {
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

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ImageConstant.starOutline2), for: .normal)
        button.setImage(UIImage(named: ImageConstant.starFilled2), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        return button
    }()

    private let cookItButton: UIButton = {
        let buton = UIButton()
        buton.backgroundColor = .customGreen2
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

        showEmptyTable = true
        tableView.reloadData()
        setupConstraints()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
        tableView.register(InstructionTableViewCell.self, forCellReuseIdentifier: InstructionTableViewCell.identifier)

        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        configuretableViewToggle()

        checkFavorite()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let saveServign = servings
        guard let saveCalorie = cal else { return }
        presenter.updateRecipeInfo(servings: saveServign, calorie: saveCalorie)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageOnTop.layer.addSublayer(gradientDark)
    }

    private func configuretableViewToggle() {
        let instructionButton = { [weak self] in
            guard let self = self else { return }
            self.tableViewToggle = false
            self.toogleTableView()
        }

        let ingredientButton = { [weak self] in
            guard let self = self else { return }
            self.tableViewToggle = true
            self.toogleTableView()
        }

        tableSwitcher.configure(ingredientButton: ingredientButton, instructionButton: instructionButton)
    }

    private func makeBlurCycle() -> DarkBlurEffectView {
        let view = DarkBlurEffectView()
        view.frame = CGRect(x: 0, y: 0, width: .cycleHeightAndWidth, height: .cycleHeightAndWidth)
        view.alpha = 0.8
        view.layer.cornerRadius = .cycleHeightAndWidth / 2
        view.clipsToBounds = true
        view.backgroundColor = .additionalBlurViewBackground
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    private func toogleTableView() {
        tableView.setContentOffset(.zero, animated: false)
        tableView.reloadData()
    }

    @objc
    private func favoriteButtonTapped() {
        favoriteButton.isSelected = !favoriteButton.isSelected
        guard let recipe = presenter.recipe else { return }
        presenter.saveDeleteFavoriteRecipe(recipe: recipe, action: .fromFavorite)
    }

    @objc
    private func tapBackButton() {
        presenter.backButtonDidPressed()
    }

    private func checkFavorite() {
        guard let recipe = presenter.recipe else { return }
        presenter.checkRecipeInRealm(id: recipe.id) ? (favoriteButton.isSelected = true) : (favoriteButton.isSelected = false)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource

 extension IngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showEmptyTable {
            return 10
        } else {
            if tableViewToggle {
                return presenter.recipe?.extendedIngredients.count ?? 25
            } else {
                return presenter.recipe?.analyzedInstructions[0].steps.count ?? 25
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewToggle {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as? IngredientsTableViewCell else {
                return UITableViewCell() }
            cell.selectionStyle = .none
            if showEmptyTable {
                cell.configureEmptyCell()
                return cell
            } else {
                guard let model = presenter.recipe?.extendedIngredients[indexPath.row] else { return UITableViewCell() }
                let foodWeight: String = "\(model.measures.metric.amount.rounded(toPlaces: 2)) \(model.measures.metric.unitShort)"
                cell.configure(imageUrl: model.image, foodName: model.originalName, foodWeight: foodWeight)
                return cell
            }
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionTableViewCell.identifier, for: indexPath) as? InstructionTableViewCell else {
                return UITableViewCell() }
            cell.selectionStyle = .none
            if showEmptyTable {
                cell.configureEmptyCell()
                return cell
            } else {
                guard let model = presenter.recipe?.analyzedInstructions[0].steps[indexPath.row] else { return UITableViewCell() }
                cell.configure(number: model.number, stepDescription: model.step)
                return cell
            }
        }
    }
 }
// MARK: - ViewProtocol
extension IngredientsViewController: IngridientViewProtocol {
    func setDataToView(recipe: DetailRecipe?) {
        guard let recipeData = recipe else {
            failure()
            return
        }

        servings = recipeData.servings
        cal = recipeData.nutrition?.nutrients[0].amount
        readyInMinutes = recipeData.readyInMinutes

        let minusButton = { [weak self] in
            guard let self = self else { return }
            if let previousCal = self.cal {
                self.cal = previousCal / Double(self.servings) * Double(self.servings - 1)
            }
            self.servings -= 1
            self.recipeInfoView.changeInfo(time: self.readyInMinutes, serving: self.servings, calorie: self.cal)
        }

        let plusButton = { [weak self] in
            guard let self = self else { return }
            if let previousCal = self.cal {
                self.cal = previousCal / Double(self.servings) * Double(self.servings + 1)
            }
            self.servings += 1
            self.recipeInfoView.changeInfo(time: self.readyInMinutes, serving: self.servings, calorie: self.cal)
        }

        imageOnTop.kf.setImage(with: URL(string: recipeData.image ?? ""))
        gradientDark.isHidden = false
        ingredientDiscriptionLabel.text = recipeData.title
        numberTogle.configure(servingsInt: servings, minussButton: minusButton, plusButton: plusButton)

        recipeInfoView.configure(time: readyInMinutes, serving: servings, calorie: cal)

        checkFavorite()
        showEmptyTable = false
        tableView.reloadData()
    }

    func failure() {
    }
}

// MARK: - Constraints
extension IngredientsViewController {

    private func setupConstraints() {
        view.addSubview(imageOnTop)
        view.addSubview(viewFromBottom)
        view.addSubview(ingredientDiscriptionLabel)
        view.addSubview(recipeInfoView)
        view.addSubview(numberTogle)
        view.addSubview(cycleBlurView1)
        view.addSubview(cycleBlurView2)
        viewFromBottom.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(favoriteButton)
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

            recipeInfoView.topAnchor.constraint(equalTo: ingredientDiscriptionLabel.bottomAnchor, constant: .ingredientsStackViewTopAnchor),
            recipeInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .ingredientsStackViewTrailingAndLeadingAnchors),
            view.trailingAnchor.constraint(equalTo: recipeInfoView.trailingAnchor, constant: .ingredientsStackViewTrailingAndLeadingAnchors),

            numberTogle.topAnchor.constraint(equalTo: viewFromBottom.topAnchor, constant: .ingredientsGrayViewTopAnchor),
            numberTogle.heightAnchor.constraint(equalToConstant: .ingredientsGrayViewHeightAnchor),
            numberTogle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: numberTogle.rightAnchor, constant: .mediemLeftRightInset),

            tableSwitcher.topAnchor.constraint(equalTo: numberTogle.bottomAnchor, constant: .ingredientViewHInset),
            tableSwitcher.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .mediemLeftRightInset),
            view.rightAnchor.constraint(equalTo: tableSwitcher.rightAnchor, constant: .ingredientViewVInset),
            tableSwitcher.heightAnchor.constraint(equalToConstant: .mediumHeightAnchor),

            tableView.topAnchor.constraint(equalTo: tableSwitcher.bottomAnchor, constant: .ingredientViewHInset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .ingredientViewVInset),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: .ingredientViewVInset),

            cycleBlurView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cycleBlurView1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .ingredientsBackButtonLeftAnchor),
            cycleBlurView1.heightAnchor.constraint(equalToConstant: .cycleHeightAndWidth),
            cycleBlurView1.widthAnchor.constraint(equalToConstant: .cycleHeightAndWidth),

            backButton.centerXAnchor.constraint(equalTo: cycleBlurView1.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: cycleBlurView1.centerYAnchor),

            cycleBlurView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.rightAnchor.constraint(equalTo: cycleBlurView2.rightAnchor, constant: .ingredientsBackButtonLeftAnchor),
            cycleBlurView2.heightAnchor.constraint(equalToConstant: .cycleHeightAndWidth),
            cycleBlurView2.widthAnchor.constraint(equalToConstant: .cycleHeightAndWidth),

            favoriteButton.centerXAnchor.constraint(equalTo: cycleBlurView2.centerXAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: cycleBlurView2.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),

            cookItButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cookItButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .ingredientViewVInset),
            view.rightAnchor.constraint(equalTo: cookItButton.rightAnchor, constant: .ingredientViewVInset),
            cookItButton.heightAnchor.constraint(equalToConstant: .cookItButtonHeight)
        ])
    }
}
