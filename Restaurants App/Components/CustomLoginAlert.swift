//
//  CustomLoginAlert.swift

import Combine
import SwiftUI

struct CustomLoginAlert: View {
    @Binding var presentAlert: Bool
    var agreeButtonAction: () -> Void
    var onDismiss: (() -> Void)?
    var title: String
    var bodyText: String
    var agreeButtonText: String
    var disagreeButtonText: String
    
    fileprivate enum AlertConstants {
        static let maxAlertWidth: CGFloat = 370
        static let maxAlertHeight: CGFloat = 300
        static let buttonSpacing: CGFloat = 8
        static let minimumScaleFactor: CGFloat = 0.5
        static let alertZIndex: Double = 2
        static let cornerRadius: CGFloat = 10
        static let opacity: CGFloat = 0.75
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(AlertConstants.opacity)
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                
                HStack {
                    Text(title)
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                        .foregroundColor(ColorManager.darkTextColor)
                    
                    Spacer()
                }
                
                Divider().padding()
                
                Text(bodyText)
                    .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .lineLimit(3)
                    .minimumScaleFactor(AlertConstants.minimumScaleFactor)
                
                VStack(spacing: AlertConstants.buttonSpacing) { // Adjusted spacing between buttons to 8px
                    SecondaryButton(labelText: agreeButtonText, action: agreeButtonAction).padding(.horizontal)
                    
                    SecondaryButton(labelText: disagreeButtonText, action: dismissAlert)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            .frame(width: AlertConstants.maxAlertWidth, height: AlertConstants.maxAlertHeight)
            .background(ColorManager.lightTextColor)
            .cornerRadius(AlertConstants.cornerRadius)
        }
        .zIndex(AlertConstants.alertZIndex)
        .preferredColorScheme(.light)
    }
    private func dismissAlert() {
        withAnimation {
            self.presentAlert = false
        }
        onDismiss?()
    }
}

struct CustomLoginAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoginAlert(presentAlert: .constant(true), agreeButtonAction: {}, title: "Alert Name", bodyText: "BodyText", agreeButtonText: "Yes", disagreeButtonText: "No")
            .previewLayout(.sizeThatFits)
    }
}
