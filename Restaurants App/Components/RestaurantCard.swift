//
//  RestaurantCard.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-19.
//

import SwiftUI
import Kingfisher

struct RestaurantCard: View {
    var imageUrl: String
    var title: String
    var tags: String
    var time: String
    var rating: String
    let cardHeight: CGFloat = 180

    var body: some View {
        ZStack {
            RoundedCorner(radius: 12, corners: [.topLeft, .topRight])
                .fill(Color.white)
                .frame(height: cardHeight)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 8) {
                
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()
                    .cornerRadius(12, corners: [.topLeft, .topRight])

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        StyledTextView(textStyle: .title1, text:title)
                            .foregroundColor(ColorManager.darkTextColor)
                        Spacer()
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            StyledTextView(textStyle: .footer1, text: rating)
                                .foregroundColor(ColorManager.darkTextColor)
                        }
                    }

                    StyledTextView(textStyle: .subtitle1, text: tags)
                        .foregroundColor(ColorManager.subtitleColor)

                    StyledTextView(textStyle: .footer1, text: time)
                        .foregroundColor(ColorManager.darkTextColor)
                }
                .padding([.leading, .trailing, .bottom], 10)

                Spacer()
            }
        }
        .frame(height: cardHeight)
    }
}

#Preview {
    RestaurantCard(
        imageUrl: "1028",
        title: "Amazing Restaurant",
        tags: "Tag • Tag • Tag ",
        time: "30 mins", rating: "3.5"
    )
}
