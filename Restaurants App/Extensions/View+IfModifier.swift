//
//  View+IfModifier.swift
//  WasaKredit
//
//  Created by Caio dos Santos Ambrosio on 2023-09-01.
//  Copyright © 2023 Wasa Kredit. All rights reserved.
//

import SwiftUI

extension View {
    /// Applies the given modifier if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - modifier: The modifier to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func ifModifier<Content: View>(
        _ condition: @autoclosure () -> Bool,
        modifier: (Self) -> Content) -> some View {
        if condition() {
            modifier(self)
        } else {
            self
        }
    }
}
