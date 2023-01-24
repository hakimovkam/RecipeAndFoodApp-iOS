//
//  IngredientsViewController.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 24.01.2023.
//

import UIKit


class IngredientsViewController: UIViewController {

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
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        label.textColor = .white
        label.font = UIFont(name: "Poppins-Bold", size: 50)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageOnTopConstraints()
        viewFromBottomConstraints()
        labelConstraints()
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
        view.addSubview(ingredientLabel)
        NSLayoutConstraint.activate([
            ingredientLabel.bottomAnchor.constraint(equalTo: imageOnTop.bottomAnchor, constant: -20),
            ingredientLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ingredientLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }


}

