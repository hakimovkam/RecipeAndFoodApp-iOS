//
//  UITableViewDelegateExtension.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 27.02.2023.
//

import UIKit

extension UITableViewDelegate {
    func setTableViewHeader(width: CGFloat, height: CGFloat, text: String) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))

        var checkInt = 0

        let attributedText = NSMutableAttributedString()
           for letter in text.unicodeScalars {
               let myLetter: NSAttributedString
               if CharacterSet.decimalDigits.contains(letter) {
                   myLetter = NSAttributedString(string: "\(letter)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreen])
                   checkInt = 1
               } else {
                   myLetter = NSAttributedString(string: "\(letter)")
               }
               attributedText.append(myLetter)
           }

        // MARK: - label
        let label = UILabel()
        label.backgroundColor = .clear
        label.frame = CGRect.init(x: 16, y: 14, width: width, height: 24)
        if checkInt == 1 {
            label.attributedText = attributedText
        } else {
            label.text = text
        }
        label.font = UIFont(name: "Poppins-Bold", size: 24)

        // MARK: - blurEffect
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = LightBlurEffectView(effect: blurEffect, intensity: 0.2)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = headerView.frame

        let additionalView: UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: width, height: height)
            view.backgroundColor = .white
            view.alpha = 0.7
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        // MARK: - gradient
        let gradientView: UIView = {
            let view = UIView()
            view.frame = headerView.frame
            view.backgroundColor = .white
            let gradient = CAGradientLayer()
            gradient.frame = headerView.frame
            gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0, 1]
            view.layer.mask = gradient
            return view
        }()

        // MARK: - added view components to the table view header

        headerView.addSubview(blurView)
        headerView.addSubview(additionalView)
        headerView.addSubview(gradientView)
        headerView.addSubview(label)

        return headerView
    }
}
