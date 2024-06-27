//
//  TextField.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct RATextField: View {
    // MARK: - PROPERTIES

    var text: Binding<String>
    let label: String
    var placeholder: String?
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .sentences

    @Binding var status: ValidatorResult
    let validator: Validator

    // MARK: - BODY

    var body: some View {
        VStack {
            HStack(spacing: .zero) {
                VStack(spacing: 6) {
                    Text(label)
//                        .font(Font(Theme.currentTheme.title3Font))
                        .textCase(.uppercase)
                        .foregroundColor(ColorManager.subtitleColor)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField(placeholder ?? "", text: text) { changed in
                        if !changed {
                            status = .ongoing
                            status = validator.validate(text.wrappedValue)
                        }
                    } onCommit: {
                        status = validator.validate(text.wrappedValue)
                    }
                    .keyboardType(keyboardType)
                    .autocapitalization(autocapitalization)
                    .textContentType(.oneTimeCode)
                    .autocorrectionDisabled()
                } //: VSTACK
                .padding(.vertical, 11)
                .padding(.horizontal, 16)
            }
            .border(Color.gray, width: 2)
            .background(Color.red)
            .ifModifier(status == .invalid(""), modifier: { textField in
                textField
                    .overlay(
                        Divider()
                            .frame(height: 2)
                            .overlay(ColorManager.negativeColor),
                        alignment: .bottom
                    )
            })

            if case .invalid(let errorMessage) = status {
                Text(errorMessage)
                    .font(.system(size: 16))
                    .foregroundColor(ColorManager.negativeColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

// MARK: - PREVIEW

struct TextField_Previews: PreviewProvider {
    @State static var text: String = ""
    @State static var status: ValidatorResult = .invalid("error_message")

    static var previews: some View {
        RATextField(
            text: $text,
            label: "email",
            placeholder: "email_placeholder",
            status: $status,
            validator: EmailValidator()
        )
            .previewLayout(.sizeThatFits)
    }
}
