//
//  Order.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import Foundation

struct Order: Decodable {
    let id: String?
    let name: String?
    let dish: Dish?
}
