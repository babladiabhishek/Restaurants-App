//
//  loadingAnimation.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct loadingAnimation: View {
    // MARK: - PROPERTIES

    @Binding var loading: LoadingState<Void>

    @State private var currentImage: Int = 0
    private let imageSwitchTimer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    // MARK: - BODY

    var body: some View {
        if loading == .loading {
            ZStack {
                Rectangle()
                    .fill(ColorManager.selectedColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

                LottieSwiftUIView(loopMode: .loop, name: "loading")
                    .scaleEffect(0.5)
                    .frame(width: 390, height: 390)
            }
        }
    }
}

struct loadingAnimation_Previews: PreviewProvider {
    @State static var loading: LoadingState<Void> = .loading

    static var previews: some View {
        loadingAnimation(loading: $loading)
    }
}
