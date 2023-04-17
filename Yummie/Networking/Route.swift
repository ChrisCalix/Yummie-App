//
//  Route.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import Foundation

enum Route {

    static let baseUrl = "https://yummie.glitch.me"

    case temp

    var description: String {
        switch self {
        case .temp:
            return "/dishes/cat1"
        }
    }
}
