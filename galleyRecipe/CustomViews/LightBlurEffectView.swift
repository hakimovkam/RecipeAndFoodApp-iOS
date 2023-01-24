//
//  LightBlurEffectView.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 23.01.2023.
//

import UIKit

class LightBlurEffectView: UIVisualEffectView {
    
    var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        backgroundColor = .clear
        frame = superview.bounds //Or setup constraints instead
        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .light)
        }
        animator.fractionComplete = 0  //This is your blur intensity in range 0 - 1
    }
    
    deinit {
        animator.stopAnimation(true)
    }
}
