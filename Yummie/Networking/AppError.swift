//
//  AppError.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import Foundation

enum AppError: LocalizedError {
    
    case decodingError
    case unknownError
    case invalidUrl
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruh!!1 I have no idea what go on"
        case .invalidUrl:
            return "Hey!! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
