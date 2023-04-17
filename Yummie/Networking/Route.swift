//
//  Route.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import Foundation

enum Route {

    static let baseUrl = "https://yummie.glitch.me"

    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)

    var description: String {
        switch self {
        case .fetchAllCategories:
            return "/dish-categories"
        case let .placeOrder(dishId):
            return "/orders/\(dishId)"
        case let .fetchCategoryDishes(catId):
            return "/dishes/\(catId)"
        }

    }
}
