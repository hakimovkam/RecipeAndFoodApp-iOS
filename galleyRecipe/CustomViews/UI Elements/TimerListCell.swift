//
//  TimerListCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 28.01.2023.
//

import UIKit

class TimerListCell: UITableViewCell {

    static let identifier = "TimerListCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    
    let stackView = UIStackView()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var foodImage: UIImageView = {
        let image = UIImage(named: ImageConstant.noImage)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = false
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.775, green: 0.775, blue: 0.775, alpha: 1).cgColor
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.text = "10:33"
        label.font = UIFont(name: "Poppins-Bold", size: 14)
        label.textColor = .customGreen
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}

extension TimerListCell {
    
    func setupViews() {
        contentView.addSubview(foodImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(timerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImage.heightAnchor.constraint(equalToConstant: 40),
            foodImage.widthAnchor.constraint(equalToConstant: 40),
            foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            
            descriptionLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            timerLabel.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 16),
            
            contentView.rightAnchor.constraint(equalTo: timerLabel.rightAnchor, constant: 24),
            timerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            timerLabel.widthAnchor.constraint(equalToConstant: 60),
            timerLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
