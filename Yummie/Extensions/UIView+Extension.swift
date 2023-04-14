//
//  UIView+Extension.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
