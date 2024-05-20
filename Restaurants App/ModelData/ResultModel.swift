//
//  ResultModel.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation
struct ResultModel<T: Codable>: Codable {
    let restaurants: T?
    let error: ErrorMessage?

    enum CodingKeys: String, CodingKey {
        case restaurants
        case error
    }
}

struct ErrorMessage: Codable {
    let message: String
}
