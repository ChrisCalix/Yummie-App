//
//  AllDishes.swift
//  Yummie
//
//  Created by Christian Calixto on 17/4/23.
//

import Foundation

struct AllDishes: Decodable {
    let specials: [Dish]?
    let categories: [DishCategory]?
    let populars: [Dish]?
}
