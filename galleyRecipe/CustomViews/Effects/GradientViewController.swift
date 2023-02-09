//
//  GradientViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 26.01.2023.
//

import UIKit

class GradientViewController: UIViewController {

    private var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.75, 1]
        view.layer.mask = gradient
    }
}
