//
//  Extension.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 19.01.2023.
//

import UIKit

extension UIColor {
    static var tabBarItemLight: UIColor { .white }
    static var customGreen: UIColor { #colorLiteral(red: 0.2783429921, green: 0.6952474713, blue: 0.3004440665, alpha: 1) }
    static var textColor: UIColor { UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1) }
    static var customBorderColor: UIColor { UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1) }
    static var additionalBlurViewBackground: UIColor { UIColor(red: 0, green: 0, blue: 0, alpha: 1) }
    static var additionalViewBackground: UIColor { UIColor(red: 0, green: 0, blue: 0, alpha: 0) }
}

extension CGFloat {
    static var tableViewHeader: CGFloat { 52 }
    static var advancedTableViewHeader: CGFloat { 138 }
    static var recipeTableViewCellHeigh: CGFloat { 184 }
    static var timerTableViewCellHeigh: CGFloat { 76 }
    static var spaceBetweenCollectionCell: CGFloat { 4 }
    static var collectionViewCellHeigh: CGFloat { 32 }
    static var searchBarHeigh: CGFloat { 50 }
    static var characterXAnchor: CGFloat { 50 }
    static var smallTopAndBottomInset: CGFloat { 8 }
    static var mediemLeftRightInset: CGFloat { 16 }
    static var headerLabelTopAnchor: CGFloat { 20 }
    
    static var sortButtonLeftAnchor: CGFloat { 10 }
    static var sortButtonTopAnchor: CGFloat { 21 }
    static var sortButtonHeighAnchor: CGFloat { 24 }
    
    static var smallFoodImageWidthHeighAnchoor: CGFloat { 40 }
    static var smallImageLeftRightAnchor: CGFloat { 24 }
    static var timerLabelWidthAnchor: CGFloat { 60 }
    static var mediumHeightAnchor: CGFloat { 24 }
    static var smallLeftRightInset: CGFloat { 8 }
    
    static var blurViewWidthAnchoor: CGFloat { 40 }
    static var blurViewHeightAnchoor: CGFloat { 80 }
    static var largeAdditionalViewAnchoor: CGFloat { 44 }
    static var mediemAdditionalViewAnchoor: CGFloat { 20 }
    static var smallAdditionalViewAnchoor: CGFloat { 12 }
}

extension UITableViewDelegate {
    func setTableViewHeader(width: CGFloat, height: CGFloat, text: String) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
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
<<<<<<<< HEAD:galleyRecipe/CustomViews/Extension/Extension.swift
========
    
>>>>>>>> b427e31 (Add emptyView for SearchViewController.):galleyRecipe/CustomViews/Extension/UIExtension.swift
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

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
<<<<<<<< HEAD:galleyRecipe/CustomViews/Extension/Extension.swift
========
}

extension String {
    
//    func widthOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSFontAttributeName: font]
//        let size = self.size(attributes: fontAttributes)
//        return size.width
//    }
>>>>>>>> b427e31 (Add emptyView for SearchViewController.):galleyRecipe/CustomViews/Extension/UIExtension.swift
}
