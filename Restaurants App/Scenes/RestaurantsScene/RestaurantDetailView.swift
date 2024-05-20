//
//  RestaurantDetailView.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-16.
//

import SwiftUI

struct RestaurantDetailView: View {
    var data: Restaurant
    var viewModel: RestaurantDetailViewModel
    
    var body: some View {
        RestaurantDetailCard(data: data, viewModel: viewModel)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRestaurant = Restaurant(
            name: "Hello",
            imageURL: "",
            id: "1",
            filterIDS: ["11222", "33333"],
            rating: 9.0,
            deliveryTimeMinutes: 0,
            tags: [
                Filter(name: "Sample Tag 1", id: "11222", imageURL: ""),
                Filter(name: "Sample Tag 2", id: "33333", imageURL: "")
            ]
        )
        let sampleNetworkManager = NetworkAPIManager.shared
        let sampleViewModel = RestaurantDetailViewModel(networkManager: sampleNetworkManager)
        
        RestaurantDetailView(data: sampleRestaurant, viewModel: sampleViewModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

