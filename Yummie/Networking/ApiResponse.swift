//
//  ApiResponse.swift
//  Yummie
//
//  Created by Christian Calixto on 17/4/23.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
