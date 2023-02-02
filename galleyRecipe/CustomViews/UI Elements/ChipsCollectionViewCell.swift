//
//  CollectionViewCell.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 02.02.2023.
//

import UIKit

class ChipsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChipsCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.backgroundColor = .white
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 16
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "soups"
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
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
