//
//  TableViewCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 21.01.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    var recipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var foodImage: UIImageView = {
        let image = UIImage(named: ImageConstant.noImage)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill // эта штука не шакалит картинку
        imageView.frame = CGRect(x: 0, y: 0, width: 358, height: 120) // размеры окна куда помещается картинка
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
  
    private let additionalBlurView: DarkBlurEffectView = {
        let view = DarkBlurEffectView()
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let additionalView: UIView = {
        let view = DarkBlurEffectView()
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.alpha = 0
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
        
    let favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageConstant.starFilled)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let timerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageConstant.timerOutline)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
}

//MARK: - Set up UI
extension CustomTableViewCell {
    
    func setupViews() {
        contentView.addSubview(recipeDescriptionLabel)
        contentView.addSubview(foodImage)
        foodImage.addSubview(additionalBlurView)
        foodImage.addSubview(additionalView)
        foodImage.addSubview(favoriteButton)
        foodImage.addSubview(timerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            contentView.bottomAnchor.constraint(equalTo: recipeDescriptionLabel.bottomAnchor, constant: 8),
            recipeDescriptionLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 8),
            recipeDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: recipeDescriptionLabel.trailingAnchor, constant: 8),
            
            recipeDescriptionLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 8),
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            foodImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            additionalBlurView.widthAnchor.constraint(equalToConstant: 40),
            additionalBlurView.heightAnchor.constraint(equalToConstant: 80),
            foodImage.trailingAnchor.constraint(equalTo: additionalBlurView.trailingAnchor, constant: 20),
            additionalBlurView.topAnchor.constraint(equalTo: foodImage.topAnchor, constant: 20),
            
            additionalView.widthAnchor.constraint(equalToConstant: 40),
            additionalView.heightAnchor.constraint(equalToConstant: 80),
            additionalView.trailingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: -20),
            additionalView.topAnchor.constraint(equalTo: foodImage.topAnchor, constant: 20),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            favoriteButton.topAnchor.constraint(equalTo: additionalView.topAnchor, constant: 12),
             additionalView.bottomAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 44),
            favoriteButton.leftAnchor.constraint(equalTo: additionalView.leftAnchor, constant: 8),
            additionalView.rightAnchor.constraint(equalTo: favoriteButton.rightAnchor, constant: 8),
            
            timerButton.widthAnchor.constraint(equalToConstant: 24),
            timerButton.heightAnchor.constraint(equalToConstant: 24),
            timerButton.topAnchor.constraint(equalTo: additionalView.topAnchor, constant: 44),
            additionalView.bottomAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: 12),
            timerButton.leftAnchor.constraint(equalTo: additionalView.leftAnchor, constant: 8),
            additionalView.rightAnchor.constraint(equalTo:timerButton.rightAnchor , constant: 8)
        ])
    }
}
