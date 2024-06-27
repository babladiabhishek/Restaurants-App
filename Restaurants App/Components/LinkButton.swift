//
//  LinkButton.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct LinkButton: View {
    // MARK: - PROPERTIES

    @State var icon: Image
    @State var color: Color
    @State var linkLabel: String
    @State var linkDestination: String

    // MARK: - BODY

    var body: some View {
        HStack(spacing: 16) {
            icon
                .renderingMode(.template)
                .foregroundColor(color)

            Link(
                linkLabel,
                destination: URL(string: linkDestination)!
            )
            .foregroundColor(color)
            .font(.system(size: 16))

            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - PREVIEW

struct WKLinkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LinkButton(
            icon: Image(systemName: "square.and.arrow.up.on.square"),
            color: Color(.black),
            linkLabel: "click to pay website",
            linkDestination: "https://www.google.com/"
        )
    }
}
