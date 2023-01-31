//
//  IngredientsViewController.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 24.01.2023.
//

import UIKit


class IngredientViewController: GradientViewController {

    var presenter: IngridientViewPresenterProtocol!
    
    // MARK: - UI
    
    //image
    let imageOnTop: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imageOnTop")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //bol'shaya vyuha
    let viewFromBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20.0
//        view.clipsToBounds = true //что ето такое
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        label.configureLabels()
//        label.font = UIFont(name: "Poppins-Bold", size: 50.0) найти как добавить фонт
        label.font = UIFont(name: "ArialRoundedMTBold", size: 24)
        label.shadowOffset = CGSize(width: 20, height: 20)
            //сделать градиент вместо тени
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageOnTopConstraints()
        viewFromBottomConstraints()
        labelConstraints()
        stackViewConstraints()
        addSublabelsToStackView()
    }
    
    func addSublabelsToStackView() {
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
    
    // MARK: - Constraints
    
    func imageOnTopConstraints() {
        view.addSubview(imageOnTop)
        NSLayoutConstraint.activate([
            imageOnTop.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageOnTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageOnTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageOnTop.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func viewFromBottomConstraints() {
        view.addSubview(viewFromBottom)
        NSLayoutConstraint.activate([
            viewFromBottom.topAnchor.constraint(equalTo: imageOnTop.bottomAnchor),
            viewFromBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            viewFromBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            viewFromBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func labelConstraints() {
        imageOnTop.addSubview(ingredientLabel)
        NSLayoutConstraint.activate([
            ingredientLabel.bottomAnchor.constraint(equalTo: imageOnTop.bottomAnchor, constant: -40),
            ingredientLabel.leadingAnchor.constraint(equalTo: imageOnTop.leadingAnchor, constant: 10),
            imageOnTop.trailingAnchor.constraint(equalTo: ingredientLabel.trailingAnchor, constant: 10),
            ingredientLabel.centerXAnchor.constraint(equalTo: imageOnTop.centerXAnchor)
        ])
    }
    
    func stackViewConstraints() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: ingredientLabel.bottomAnchor, constant: 5),
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

extension UILabel {
    func configureLabels() {
        self.textColor = .white
    }
}

// extension presenter
extension IngredientViewController: IngridientViewProtocol {
    
}
