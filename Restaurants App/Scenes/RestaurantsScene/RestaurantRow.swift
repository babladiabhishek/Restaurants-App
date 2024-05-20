//
//  RestaurantRow.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-16.
//

import SwiftUI

struct RestaurantRow: View {
    var data: Restaurant
    
    var body: some View {
        RestaurantCard(
            imageUrl: data.imageURL,
            title: data.name,
            tags: tagsDescription(for: data),
            time: "\(data.deliveryTimeMinutes) Mins",
            rating: "\(data.rating)"
        )
    }
    
    
    private func tagsDescription(for restaurant: Restaurant) -> String {
        if restaurant.tags.isEmpty {
            return "No tags available"
        }
        return restaurant.tags.map { $0.name }.joined(separator: " • ")
    }
}


#Preview {
    RestaurantRow(data: Restaurant(name: "Hello", imageURL: "vsdsdgdsg", id: "1", filterIDS: ["11222","33333"], rating: 9.0, deliveryTimeMinutes: 0))
}
