//
//  CountryCollectionView.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 02.02.2023.
//

import UIKit

class CountryCollectionView: UICollectionView {
    
    var countryCategoryArray = ["🏴", "🇦🇱", "🏴‍☠️", "🏁", "🏴", "🇦🇱", "🏴‍☠️", "🏁", "🏴", "🇦🇱", "🏴‍☠️", "🏁"]
    
    private let chipsLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: chipsLayout)
        
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(ChipsCollectionViewCell.self, forCellWithReuseIdentifier: ChipsCollectionViewCell.identidierCountry)
        chipsLayout.minimumInteritemSpacing = 5
        chipsLayout.scrollDirection = .horizontal
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


//MARK: - Delegate&DataSource
extension CountryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return countryCategoryArray.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ChipsCollectionViewCell.identidierCountry, for: indexPath) as! ChipsCollectionViewCell
        cell.label.text = countryCategoryArray[indexPath.row]
        
        return cell
    }
}

//MARK: - DelegateFlowLayout
extension CountryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayaut: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = UIFont(name: "Poppins-Regular", size: 14)
        let categoryAttributes = [NSAttributedString.Key.font : categoryFont as Any]
        let categoryWidth = countryCategoryArray[indexPath.item].size(withAttributes: categoryAttributes).width + 30
        
        return CGSize(width: categoryWidth, height: collectionView.frame.height)
    }
}


