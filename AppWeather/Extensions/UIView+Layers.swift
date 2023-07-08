//
//  UIView+Layers.swift
//  AppWeather
//
//  Created by  MacOS on 11.08.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func setCornerRadius(_ radius: CGFloat){
        self.layer.cornerRadius = radius
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
