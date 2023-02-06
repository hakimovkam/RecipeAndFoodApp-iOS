//
//  IngredientsTableViewCell.swift
//  galleyRecipe
//
//  Created by Philipp Zeppelin on 30.01.2023.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell {
    
    private let idOptionalTableViewCell = "idOptionalTableViewCell"
    
    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Pasta")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let foodNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pasta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let foodWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "400 g"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        self.addSubview(circleImage)
        NSLayoutConstraint.activate([
            circleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            circleImage.widthAnchor.constraint(equalToConstant: 35),
            circleImage.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        self.addSubview(foodNameLabel)
        NSLayoutConstraint.activate([
            foodNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            foodNameLabel.leftAnchor.constraint(equalTo: circleImage.rightAnchor, constant: 30)
        ])
        
        self.addSubview(foodWeightLabel)
        NSLayoutConstraint.activate([
            foodWeightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.rightAnchor.constraint(equalTo: foodWeightLabel.rightAnchor, constant: 30)
        ])
    }
}



