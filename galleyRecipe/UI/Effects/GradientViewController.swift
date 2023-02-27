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
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        gradient.locations = [0.75, 1]
        return gradient
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layer.addSublayer(gradient)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
