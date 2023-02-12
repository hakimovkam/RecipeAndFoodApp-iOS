//
//  GradientViewController.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 26.01.2023.
//

import UIKit

class GradientViewController: UIViewController {

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.75, 1]
        return gradient
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layer.mask = gradient
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
