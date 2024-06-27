//
//  LottieSwiftUIView.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI
import Lottie

struct LottieSwiftUIView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    var name: String

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}

struct LottieSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LottieSwiftUIView(loopMode: .loop, name: "loading")
            .scaleEffect(0.4)
            .frame(width: 390, height: 390)
    }
}

