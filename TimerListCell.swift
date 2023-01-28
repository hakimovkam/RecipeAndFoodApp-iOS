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
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 5
        
        label.frame = CGRect(x: 0, y: 0, width: 178, height: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var foodImage: UIImageView = {
        let image = UIImage(named: ImageConstant.noImage)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        
//        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "10:33"
        label.font = UIFont(name: "Poppins-Bold", size: 14)
        label.textColor = .customGreen
        label.frame = CGRect(x: 0, y: 0, width: 36, height: 20)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        
        let layer = CALayer()
        layer.frame = CGRect(x: -12, y: -2.5, width: 60, height: 24)
        layer.borderWidth = 1
        label.layer.addSublayer(layer)
    
        layer.borderColor = UIColor(red: 0.775, green: 0.775, blue: 0.775, alpha: 1).cgColor
        layer.cornerRadius = 12

        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension TimerListCell {
    
    func setupViews() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(foodImage)
        contentView.addSubview(timerLabel)
        
        print(timerLabel.frame)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImage.heightAnchor.constraint(equalToConstant: 40),
            foodImage.widthAnchor.constraint(equalToConstant: 40),
            foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            descriptionLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: timerLabel.leftAnchor, constant: -28),
            
//            timerLabel.heightAnchor.constraint(equalToConstant: 24),
//            timerLabel.widthAnchor.constraint(equalToConstant: 60),
            timerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            timerLabel.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 28)
            
            
        ])
    }
}
