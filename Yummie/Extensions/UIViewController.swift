//
//  UIViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit

extension UIViewController {

    static var identifier: String {
        return String(describing: self)
    }

    static func instantiate() -> Self {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)

        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
