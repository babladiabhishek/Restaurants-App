//
//  InfoBlock.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct InfoBlock: View {
    // MARK: - PROPERTIES

    let icon: String
    let text: String
    let textColor: Color
    let backgroundColor: Color
    let cornerRadius: CGFloat

    // MARK: - BODY

    var body: some View {
        HStack(spacing: 8) {
            Image(icon)
                .foregroundColor(.blue)
                .font(Font.headline.weight(.bold))
                .colorScheme(.light)

            Text(text)
                .font(.system(size: 17))
                .foregroundColor(.blue)
        }
        .padding(16)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    InfoBlock(
        icon: "infoIcon",
        text: "some Text",
        textColor: ColorManager.darkTextColor,
        backgroundColor: .red,
        cornerRadius: 8
    )
        .previewLayout(.sizeThatFits)
}
