//
//  DishCategory.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import Foundation

struct DishCategory: Decodable {
    let id, name, image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
