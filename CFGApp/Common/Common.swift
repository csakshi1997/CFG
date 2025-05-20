//
//  Common.swift
//  CFGApp
//
//  Created by Sakshi on 22/01/25.
//

import Foundation
import UIKit

func addShadow(to view: UIView) {
    view.layer.shadowColor = UIColor(red: 213.0 / 255.0, green: 214.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0).cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: -3, height: 3)
    view.layer.shadowRadius = 4
    view.layer.masksToBounds = false
}

func addShadowOnButton(to button: UIButton) {
    button.layer.shadowColor = UIColor(red: 213.0 / 255.0, green: 214.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0).cgColor
    button.layer.shadowOpacity = 0.5
    button.layer.shadowOffset = CGSize(width: -3, height: 3)
    button.layer.shadowRadius = 4
    button.layer.masksToBounds = false
}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 3.5
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}

extension UIButton {
    func shadowDecorateButton() {
        let radius: CGFloat = 10
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 3.5
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}

extension UIView {
    func shadowDecorateForView() {
        let radius: CGFloat = 10
        layer.cornerRadius = radius
        layer.masksToBounds = false // Allows shadow to be visible
        layer.shadowColor = UIColor.black.cgColor // Softer shadow color
        layer.shadowOffset = CGSize(width: 0, height: 4) // More natural shadow placement
        layer.shadowRadius = 6 // Increased for smooth diffusion
        layer.shadowOpacity = 0.2 // Lighter opacity for a subtle effect
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
}


