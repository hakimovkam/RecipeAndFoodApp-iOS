//
//  CollectionViewCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 02.02.2023.
//

import UIKit

class ChipsCollectionViewCell: UICollectionViewCell {
    static let identifierCategory = "CategoryChipsCell"
    static let identidierCountry = "CountryChipsCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = false
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.backgroundColor = .clear
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.775, green: 0.775, blue: 0.775, alpha: 1).cgColor
        label.layer.cornerRadius = 16
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
