//
//  View+HideKeyboard.swift
//  WasaKredit
//
//  Created by Caio dos Santos Ambrosio on 2023-08-28.
//  Copyright © 2023 Wasa Kredit. All rights reserved.
//

import SwiftUI
import Combine

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
