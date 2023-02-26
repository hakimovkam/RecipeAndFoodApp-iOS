//
//  ChipsCollectionView.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 02.02.2023.
//

import UIKit

final class ChipsCollectionView: UICollectionView {

    private let chipsLayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        let insertLeft: CGFloat = 16
        let insertRight: CGFloat = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: insertLeft, bottom: 0, right: insertRight)
        return layout
    }()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: chipsLayout)
        backgroundColor = .clear
        register(ChipsCollectionViewCell.self, forCellWithReuseIdentifier: ChipsCollectionViewCell.identifier)
        showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
