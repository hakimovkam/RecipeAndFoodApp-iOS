//
//  UIExtension.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 19.01.2023.
//

import UIKit

extension UIColor {
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 1, green: 0.5963680148, blue: 0, alpha: 1)
    }
    
    static var mainWhite: UIColor {
        .lightGray
    }
    
    static var tabBarItemLight: UIColor {
        .white
    }
    
    static var alphaImage: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9190072696)
    }
    
    static var customGreen: UIColor {
        #colorLiteral(red: 0.2783429921, green: 0.6952474713, blue: 0.3004440665, alpha: 1)
    }
}

extension UITableViewDelegate {
    func setTableViewHeader(width: CGFloat, height: CGFloat, text: String) -> UIView {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        var checkInt = 0

        let attributedText = NSMutableAttributedString()
           for letter in text.unicodeScalars {
               let myLetter : NSAttributedString
               if CharacterSet.decimalDigits.contains(letter) {
                   myLetter = NSAttributedString(string: "\(letter)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreen])
                   checkInt = 1
               } else {
                   myLetter = NSAttributedString(string: "\(letter)")
               }
               attributedText.append(myLetter)
           }
        
        /* set custom blur effect in tableViewHeader */
        //MARK: - label
        let label = UILabel()
        label.backgroundColor = .clear
        label.frame = CGRect.init(x: 16, y: 14, width: width, height: 24)
        if checkInt == 1 {
            label.attributedText = attributedText
        } else {
            label.text = text
        }
        label.font = UIFont(name: "Poppins-Bold", size: 24)
//        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
//        label.minimumScaleFactor = 0.5
        
        //MARK: - blurEffect
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = LightBlurEffectView(effect: blurEffect, intensity: 0.2)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = headerView.frame
        
        let additionalView: UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width:width, height: height)
            view.backgroundColor = .white
            view.alpha = 0.7
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()
        
        //MARK: - gradient
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
        
        //MARK: - added view components to the table view header
        
        headerView.addSubview(blurView)
        headerView.addSubview(additionalView)
        headerView.addSubview(gradientView)
        headerView.addSubview(label)
        
        return headerView
    }
    
//    func setTitleForHeaderTableView(width: CGFloat, height: CGFloat, text: String
    
}

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        var border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, UIScreen.main.bounds.width, thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}
