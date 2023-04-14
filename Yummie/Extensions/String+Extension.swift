//
//  String+Extension.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
