//
//  RestaurantStatus.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation
struct OpenStatus: Codable {
    let isCurrentlyOpen: Bool
    let restaurantID: String

    var description: String {
        return isCurrentlyOpen ? "Open" : "Closed"
    }

    enum CodingKeys: String, CodingKey {
        case isCurrentlyOpen = "is_currently_open"
        case restaurantID = "restaurant_id"
    }
}
