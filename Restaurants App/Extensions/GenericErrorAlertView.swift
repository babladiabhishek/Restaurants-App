//
//  GenericErrorAlertView.swift
//  WasaKredit
//
//  Created by Abhishek Babladi on 2024-02-02.
//  Copyright © 2024 Wasa Kredit. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func errorAlert(errorMessage: Binding<String?>, buttonTitle: String = "OK") -> some View {
        self.alert(isPresented: .constant(errorMessage.wrappedValue != nil)) {
            Alert(
                title: Text("Information"),
                message: {
                    Text(errorMessage.wrappedValue ?? "An error occurred")
                }(),
                dismissButton: .default(Text(buttonTitle)) {
                    errorMessage.wrappedValue = nil
                }
            )
        }
    }
}
