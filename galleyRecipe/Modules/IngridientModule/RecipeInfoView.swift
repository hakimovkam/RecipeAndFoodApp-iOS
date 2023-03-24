//
//  RecipeInfoView.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 24.03.2023.
//

import UIKit

final class RecipeInfoView: UIView {

    var labelWidtht: CGFloat = 0
    var waitingTime: Int = 0
    var servings: Int = 0
    var calories: Double? = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var waitingTimeLabel = makeLabel()
    private lazy var servingsLabel = makeLabel()
    private lazy var caloriesLabel = makeLabel()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1

        return stackView
    }()

    func configure(time: Int, serving: Int, calorie: Double?) {
        waitingTime = time
        servings = serving
        calories = calorie

        setConstraint()
    }

    func changeInfo(time: Int, serving: Int, calorie: Double?) {
        waitingTimeLabel.attributedText = attributedStringWithBold(for: String(time) + " min")
        servingsLabel.attributedText = attributedStringWithBold(for: String(serving) + " servings")
        if let cal = calorie {
            caloriesLabel.attributedText = attributedStringWithBold(for: String(cal.rounded(toPlaces: 1)) + " cal")
        }
    }

    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func attributedStringWithBold(for string: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]

        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)

        let digitSet = CharacterSet.decimalDigits
        var searchRange = string.startIndex..<string.endIndex
        while let range = string.rangeOfCharacter(from: digitSet, options: [], range: searchRange) {
            let digitStartIndex = string.distance(from: string.startIndex, to: range.lowerBound)
            let digitEndIndex = string.distance(from: string.startIndex, to: range.upperBound)

            let digitAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Poppins-SemiBold", size: 16) ?? UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
            ]

            attributedString.addAttributes(digitAttributes, range: NSRange(location: digitStartIndex, length: digitEndIndex - digitStartIndex))

            searchRange = range.upperBound..<string.endIndex
        }

        return attributedString
    }

    private func setConstraint() {

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])

        var labelWidth: CGFloat = 0

        if calories != nil {
            labelWidth = frame.width / 3
        } else {
            labelWidth = frame.width / 2
        }

        print(frame.width)
        print(frame.width / 3)

        let timeView = UIView(frame: CGRect(x: 0, y: 0, width: labelWidth, height: waitingTimeLabel.bounds.height))
        let servingsView = UIView(frame: CGRect(x: 0, y: 0, width: labelWidth, height: servingsLabel.bounds.height))

        let separator = SeparatorView()
        let separator2 = SeparatorView()

        waitingTimeLabel.attributedText = attributedStringWithBold(for: (String(waitingTime) + " min"))
        waitingTimeLabel.textColor = .white

        servingsLabel.attributedText = attributedStringWithBold(for: (String(servings) + " servings"))
        servingsLabel.textColor = .white
        stackView.distribution = .equalCentering

        timeView.addSubview(waitingTimeLabel)
        stackView.addArrangedSubview(timeView)

        stackView.addArrangedSubview(separator)

        servingsView.addSubview(servingsLabel)
        stackView.addArrangedSubview(servingsView)

        if let cal = calories {
            let caloriesView = UIView()
            caloriesLabel.attributedText = attributedStringWithBold(for: (String(cal) + " cal"))

            stackView.addArrangedSubview(separator2)
            caloriesView.addSubview(caloriesLabel)
            stackView.addArrangedSubview(caloriesView)
            caloriesLabel.textColor = .white

            NSLayoutConstraint.activate( [
                caloriesLabel.centerXAnchor.constraint(equalTo: caloriesView.centerXAnchor),
                caloriesView.widthAnchor.constraint(equalToConstant: labelWidth)

    ])
        }

        NSLayoutConstraint.activate([
            timeView.widthAnchor.constraint(equalToConstant: labelWidth),
            servingsView.widthAnchor.constraint(equalToConstant: labelWidth),
            waitingTimeLabel.centerXAnchor.constraint(equalTo: timeView.centerXAnchor),
            servingsLabel.centerXAnchor.constraint(equalTo: servingsView.centerXAnchor)
        ])
    }
}
