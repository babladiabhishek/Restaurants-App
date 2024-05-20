//
//  Restaurant.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-14.
//

import Foundation
// MARK: - Restaurant
struct Restaurant: Codable, Hashable {
    let name: String
    let imageURL: String
    let id: String
    let filterIDS: [String]
    let rating: Double
    let deliveryTimeMinutes: Int
    var tags: [Filter] = []
    
       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case id
        case filterIDS = "filterIds"
        case rating
        case deliveryTimeMinutes = "delivery_time_minutes"
    }
}
