//
//  View+IfModifier.swift

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
