//
//  FilterComponent.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-05-19.
//

import SwiftUI
import Kingfisher

struct FilterComponent: View {
    @Binding var isSelected: Bool
    var filterName: String
    var imageUrl: String

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            ZStack {
                Capsule()
                    .fill(isSelected ? ColorManager.selectedColor : Color.white)
                    .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
                    .frame(width: 144, height: 48)

                HStack(spacing: 0) {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                    Spacer(minLength: 8)

                    StyledTextView(textStyle: .title2, text: filterName)
                        .foregroundColor(isSelected ? ColorManager.lightTextColor : ColorManager.darkTextColor)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 144, height: 48)
        }
        .buttonStyle(PlainButtonStyle())
    }
}



struct FilterComponent_Previews: PreviewProvider {
    static var previews: some View {
        FilterComponent(isSelected: .constant(true), filterName: "Fast Food", imageUrl: "https://food-delivery.umain.io/images/filter/filter_fast_delivery.png")
    }
}



