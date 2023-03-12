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

    var favoriteButtonTapCallback: (() -> Void) = {}
    var timerButtonTapCallback: (() -> Void) = {}
    // MARK: - UI Components
    private let recipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .customLightGray
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: .foodImageCell)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isShimmering = true

        return imageView
    }()

    private let additionalBlurView: DarkBlurEffectView = {
        let view = DarkBlurEffectView()
        view.frame = CGRect(x: 0, y: 0, width: .blurViewWidthAnchoor, height: .blurViewHeightAnchoor)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .additionalBlurViewBackground
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let additionalView: UIView = {
        let view = DarkBlurEffectView()
        view.frame = CGRect(x: 0, y: 0, width: .blurViewWidthAnchoor, height: .blurViewHeightAnchoor )
        view.layer.cornerRadius = 20
        view.backgroundColor = .additionalViewBackground
        view.alpha = 0
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var favoriteButton: SmallButon = {
        let button = SmallButon()
        let image = UIImage(named: ImageConstant.starOutline)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width: .smallImageLeftRightAnchor, height: .smallImageLeftRightAnchor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonDidPressed), for: .touchUpInside)

        return button
    }()

     private lazy var timerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ImageConstant.timerOutline)
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width: .smallImageLeftRightAnchor, height: .smallImageLeftRightAnchor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(timerButtonDidPressed), for: .touchUpInside)

        return button
    }()

    func configure(recipeDescription: String, imageUrlString: String, favoriteButton: @escaping (() -> Void), timerButotn: @escaping (() -> Void), isFavorite: Bool) {

        checkFavoriteStatus(isFavorite: isFavorite)

        foodImage.isShimmering = true
        foodImage.kf.setImage(with: URL(string: imageUrlString), options: [.transition(.fade(0.3))], completionHandler: { [weak self] _ in
            guard let self = self else { return }
            self.foodImage.isShimmering = false})

        foodImage.kf.setImage(with: URL(string: imageUrlString))
        recipeDescriptionLabel.text = recipeDescription
        favoriteButtonTapCallback = favoriteButton
        timerButtonTapCallback = timerButotn
    }

    func changeFavoriteButtonIcon(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(named: ImageConstant.starOutline), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: ImageConstant.starFilled), for: .normal)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        foodImage.image = UIImage(named: ImageConstant.noImage)
    }

    @objc
    func favoriteButtonDidPressed() {
        favoriteButtonTapCallback()

    }

    @objc
    func timerButtonDidPressed() {
        timerButtonTapCallback()
    }

    private func checkFavoriteStatus(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(named: ImageConstant.starFilled), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: ImageConstant.starOutline), for: .normal)
        }
    }
}

// MARK: - Set up UI
extension CustomTableViewCell {

    func setupViews() {
        contentView.addSubview(recipeDescriptionLabel)
        contentView.addSubview(foodImage)
        foodImage.addSubview(additionalBlurView)
        foodImage.addSubview(additionalView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(timerButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            contentView.bottomAnchor.constraint(equalTo: recipeDescriptionLabel.bottomAnchor, constant: .smallTopAndBottomInset),
            recipeDescriptionLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: .smallTopAndBottomInset),
            recipeDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .smallLeftRightInset),
            contentView.trailingAnchor.constraint(equalTo: recipeDescriptionLabel.trailingAnchor, constant: .smallLeftRightInset),

            recipeDescriptionLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: .smallTopAndBottomInset),
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .smallTopAndBottomInset),
            foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .smallLeftRightInset),
            contentView.rightAnchor.constraint(equalTo: foodImage.rightAnchor, constant: .smallLeftRightInset),

            additionalBlurView.widthAnchor.constraint(equalToConstant: .blurViewWidthAnchoor),
            additionalBlurView.heightAnchor.constraint(equalToConstant: .blurViewHeightAnchoor),
            foodImage.trailingAnchor.constraint(equalTo: additionalBlurView.trailingAnchor, constant: .mediemAdditionalViewAnchoor),
            additionalBlurView.topAnchor.constraint(equalTo: foodImage.topAnchor, constant: .mediemAdditionalViewAnchoor),

            additionalView.widthAnchor.constraint(equalToConstant: .blurViewWidthAnchoor),
            additionalView.heightAnchor.constraint(equalToConstant: .blurViewHeightAnchoor),
            foodImage.trailingAnchor.constraint(equalTo: additionalView.trailingAnchor, constant: .mediemAdditionalViewAnchoor),
            additionalView.topAnchor.constraint(equalTo: foodImage.topAnchor, constant: .mediemAdditionalViewAnchoor),

            favoriteButton.widthAnchor.constraint(equalToConstant: .mediumHeightAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: .mediumHeightAnchor),
            favoriteButton.topAnchor.constraint(equalTo: additionalView.topAnchor, constant: .smallAdditionalViewAnchoor),
            additionalView.bottomAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: .largeAdditionalViewAnchoor),
            favoriteButton.leftAnchor.constraint(equalTo: additionalView.leftAnchor, constant: .smallLeftRightInset),
            additionalView.rightAnchor.constraint(equalTo: favoriteButton.rightAnchor, constant: .smallLeftRightInset),

            timerButton.widthAnchor.constraint(equalToConstant: .mediumHeightAnchor),
            timerButton.heightAnchor.constraint(equalToConstant: .mediumHeightAnchor),
            timerButton.topAnchor.constraint(equalTo: additionalView.topAnchor, constant: .largeAdditionalViewAnchoor),
            additionalView.bottomAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: .smallAdditionalViewAnchoor),
            timerButton.leftAnchor.constraint(equalTo: additionalView.leftAnchor, constant: .smallLeftRightInset),
            additionalView.rightAnchor.constraint(equalTo: timerButton.rightAnchor, constant: .smallLeftRightInset)
        ])
    }
}
