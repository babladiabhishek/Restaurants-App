//
//  RestaurantDetailCard.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-19.
//

import SwiftUI
import Kingfisher

struct RestaurantDetailCard: View {
    let cardWidth: CGFloat = .infinity
    let cardHeight: CGFloat = 144
    var data: Restaurant
    var viewModel: RestaurantDetailViewModel

    var body: some View {
        ScrollView {
            ZStack {
                KFImage(URL(string: data.imageURL))
                    .resizable()
                VStack {
                    VStack(alignment: .leading, spacing: 8) {
                        StyledTextView(textStyle: .title1, text: data.name)
                            .foregroundColor(ColorManager.darkTextColor)

                        HStack {
                            StyledTextView(textStyle: .subtitle1, text: data.tags.map { $0.name }.joined(separator: " • "))
                                .foregroundColor(ColorManager.subtitleColor)
                        }

                        StyledTextView(textStyle: .title1, text: viewModel.status)
                            .foregroundColor(viewModel.statusColor)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    .offset(y: 120)
                }
                .padding(.leading)
                .padding(.trailing)
            }
        }
        .onAppear(perform: {
            Task{
                await viewModel.fetchStatus(for: data.id)
            }
        })
    }
}

struct RestaurantDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRestaurant = Restaurant(
            name: "Wayne \"Chad Broski\" Burgers",
            imageURL: "https://food-delivery.umain.io/images/restaurant/burgers.png",
            id: "7450001",
            filterIDS: ["5c64dea3-a4ac-4151-a2e3-42e7919a925d", "614fd642-3fa6-4f15-8786-dd3a8358cd78"],
            rating: 4.6,
            deliveryTimeMinutes: 9,
            tags: [
                Filter(name: "Top Rated", id: "5c64dea3-a4ac-4151-a2e3-42e7919a925d", imageURL: "https://food-delivery.umain.io/images/filter/filter_top_rated.png"),
                Filter(name: "Fast Food", id: "614fd642-3fa6-4f15-8786-dd3a8358cd78", imageURL: "https://food-delivery.umain.io/images/filter/filter_fast_food.png")
            ]
        )
        let sampleNetworkManager = NetworkAPIManager.shared
        let sampleViewModel = RestaurantDetailViewModel(networkManager: sampleNetworkManager)

        RestaurantDetailCard(data: sampleRestaurant, viewModel: sampleViewModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
