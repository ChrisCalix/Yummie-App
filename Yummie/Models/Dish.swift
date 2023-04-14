//
//  Dish.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import Foundation

struct Dish {
    let id: String?
    let name: String?
    let description: String?
    let image: String?
    let calories: Int?

    var formattedCalories: String {
        return "\(calories ?? .zero) calories"
    }
}
