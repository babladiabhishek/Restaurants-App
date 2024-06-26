//
//  View-SheetHeight.swift

import SwiftUI

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @available(iOS 16.0, *)
    func fixedInnerHeight(_ sheetHeight: Binding<CGFloat>) -> some View {
        presentationDragIndicator(.visible)
            .overlay {
                GeometryReader { geometry in
                    Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                }
            }
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                sheetHeight.wrappedValue = newHeight
            }
            .presentationDetents([.height(sheetHeight.wrappedValue)])
    }
}
