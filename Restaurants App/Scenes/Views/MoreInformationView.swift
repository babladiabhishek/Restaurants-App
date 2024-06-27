//
//  MoreInformationView.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct MoreInformationView: View {
    // MARK: - BODY

    var body: some View {
        VStack(spacing: .zero) {
            Text("Echoes of Eternity: Whispers Across Time")
//                .font(Font(Theme.currentTheme.title1Font))
                .foregroundColor(.titleColor)
                .padding(.vertical, 16)
                .padding(.top, 16)

            Divider()
                .padding(.bottom, 24)

            Text("Echoes of Eternity: Whispers Across Time follows the journey of a young archaeologist who stumbles upon an ancient artifact with the power to transcend time itself. As she delves deeper into its mysteries, she uncovers a web of interconnected lives spanning centuries Join her on a mesmerizing journey where every whisper carries the weight of eternity.")
                .font(.system(size: 19))
                .padding(.horizontal, 16)
                .fixedSize(horizontal: false, vertical: true)

            LinkButton(
                icon: Image(systemName: "square.and.arrow.up.on.square"),
                color: .buttonPrimaryFill,
                linkLabel: "Discover the Secrets",
                linkDestination: "www.google.com"
            )
            .padding(.vertical, 29)
        }
    }
}

// MARK: - PREVIEW

struct MoreInformationView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationView()
            .previewLayout(.sizeThatFits)
    }
}
