//
//  ChipsCollectionView.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 02.02.2023.
//

import UIKit

class CategoryCollectionView: UICollectionView {

    var nameCategoryArray = ["Soup", "Pasta", "Egg", "Apple", "Orange", "Soup", "Pasta", "Egg", "Apple", "Orange", "Soup", "Pasta", "Egg", "Apple", "Orange"] //testing data
    
    private let chipsLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: chipsLayout)
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(ChipsCollectionViewCell.self, forCellWithReuseIdentifier: ChipsCollectionViewCell.identifierCategory)
        chipsLayout.minimumInteritemSpacing = 0
        chipsLayout.scrollDirection = .horizontal
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


//MARK: - Delegate&DataSource
extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return nameCategoryArray.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ChipsCollectionViewCell.identifierCategory, for: indexPath) as! ChipsCollectionViewCell
        cell.label.text = nameCategoryArray[indexPath.row]
        
        return cell
    }
}

//MARK: - DelegateFlowLayout
extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayaut: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = UIFont(name: "Poppins-Regular", size: 14)
        let categoryAttributes = [NSAttributedString.Key.font : categoryFont as Any]
        let categoryWidth = nameCategoryArray[indexPath.item].size(withAttributes: categoryAttributes).width + 40
        
        return CGSize(width: categoryWidth, height: collectionView.frame.height)
    }
}
