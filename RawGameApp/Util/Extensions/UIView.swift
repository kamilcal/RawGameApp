//
//  UIView.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit

extension UIView {
    
    func addRoundedCorners() {
        self.clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    func addShadow() {
        clipsToBounds = false
        layer.opacity = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: -1, height: 0)
        layer.shadowOpacity = 0.4
        layer.cornerRadius = 10
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
