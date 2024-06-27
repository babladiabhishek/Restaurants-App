//
//  SecondaryButton.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct SecondaryButton: View {
    let labelText: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Hello")
                .foregroundStyle(.red)
//                .font(Font(Theme.currentTheme.title1Font))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(SecondaryButtonConfig())
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SecondaryButton(labelText: "login_test_app_button_text_no") {
                print("Button tapped!")
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

struct SecondaryButtonConfig: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let opacity: Double = configuration.isPressed ? 0.5 : 1.0

        return configuration.label
            .padding(.vertical, 18)
            .padding(.horizontal, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
//                    .stroke(Color.buttonPrimaryFill.opacity(opacity), lineWidth: 4)
                    .stroke(Color.black.opacity(opacity), lineWidth: 4)
            )
            .foregroundColor(Color.green.opacity(opacity))
            .background(Color.white)
            .cornerRadius(0)
    }
}
