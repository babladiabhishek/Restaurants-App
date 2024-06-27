//
//  LoginSheetView.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-06-27.
//

import SwiftUI

struct LoginSheetView: View {
    // MARK: - Properties
    @State var presentAlert = false
    @State private var bottomSheetShown = false

    // MARK: - Body
    var body: some View {
        ZStack {
            Color.clear
            BottomSheet(
                isOpen: self.$bottomSheetShown
            ) {
                VStack(spacing: .zero) {
                    HStack(alignment: .top) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading) {
                            Text("Hello")
                                .foregroundColor(ColorManager.darkTextColor)
                        }

                        Spacer()
                    }
                    .padding(.bottom)
                    .padding(.leading)
                    .padding(.trailing)

                    Divider()

                    Button("Hi", action: {
                        print("Hello")
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(ColorManager.darkTextColor)

                    Divider()
                        .padding(.top, 20)

                    Button(action: {
                        presentAlert.toggle()
                    }) {
                        HStack {
                            Text("Hello")
                            Spacer()
                            Image("chevron")
                        }
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                }
            }

            .ignoresSafeArea()
            .overlay {
                if presentAlert {
                    CustomLoginAlert(
                        presentAlert: $presentAlert,
                        agreeButtonAction: {
                           //TODO: Some action
                            withAnimation {
                                self.presentAlert = false
                            }
                        },
                        title: "Start Demo",
                        bodyText: "You are about to enter demo mode. Do you want to continue?",
                        agreeButtonText: "Yes, start demo",
                        disagreeButtonText: "No, cancel"

                    )
                }
            }
        }
    }
}
// MARK: - PREVIEW

struct LoginSheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.indigo.ignoresSafeArea()
                LoginSheetView()
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE (2nd generation)")
        }
    }
}
