//
//  UIView+Extension.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius  }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { self.borderColor }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { self.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set { self.layer.shadowRadius = newValue }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { self.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get { self.shadowColor }
        set { self.layer.shadowColor = newValue.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { self.shadowOpacity }
        set { self.layer.shadowOpacity = newValue }
    }
}
