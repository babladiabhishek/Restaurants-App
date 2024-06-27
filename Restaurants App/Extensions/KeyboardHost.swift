//
//  KeyboardResponder.swift
//  WasaKredit
//
//  Created by Caio dos Santos Ambrosio on 2023-08-28.
//  Copyright © 2023 Wasa Kredit. All rights reserved.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        GeometryReader { _ in
            content
                .padding(.bottom, keyboardHeight)
                .edgesIgnoringSafeArea(keyboardHeight == 0 ? [] : .bottom)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    self.keyboardHeight = keyboardHeight
                }
        }
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
