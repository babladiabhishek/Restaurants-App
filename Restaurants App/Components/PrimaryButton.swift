//
//  PrimaryButton.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct PrimaryButton: View {
    // MARK: - PROPERTIES

    let labelText: String
    let isDisabled: Bool
    let action: () -> Void

    // MARK: - BODY

    var body: some View {
        Button(action: action) {
            Text(labelText)
//                .font(Font(Theme.currentTheme.title1Font))
                .foregroundColor(isDisabled ? .buttonDisabledPrimaryTitleColor : .buttonPrimaryText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
        }
        .disabled(isDisabled)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isDisabled ? Color.buttonPrimaryFill.opacity(0.25) : Color.buttonPrimaryFill)
        )
        .cornerRadius(4)
    }
}

struct WKMainButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(labelText: "click_to_pay_approve_button", isDisabled: true) {
            print("Button clicked")
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 16)
        .previewLayout(.sizeThatFits)
    }
}
