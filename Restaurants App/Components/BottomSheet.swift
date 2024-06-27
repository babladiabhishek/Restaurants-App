//
//  BottomSheet.swift
//  Restaurants App
//
//  Created by Abhishek B on 2024-06-27.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = .zero
    let maxHeight: CGFloat = BottomSheetConstants.defaultMaxHeight
    let minHeight: CGFloat = BottomSheetConstants.defaultMinHeight
    let content: Content

    init(isOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._isOpen = isOpen
    }

    private var offset: CGFloat {
        isOpen ? .zero : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: BottomSheetConstants.radius)
            .fill(Color.gray)
            .frame(
                width: BottomSheetConstants.indicatorWidth,
                height: BottomSheetConstants.indicatorHeight
            ).onTapGesture {
                self.isOpen.toggle()
            }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.white))
            .cornerRadius(BottomSheetConstants.radius, corners: [.topLeft, .topRight])
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, .zero))
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: .zero), value: isOpen)
            .gesture(
                DragGesture().onChanged { value in
                    // Calculate the distance dragged
                    let translation = value.translation.height
                    // Determine if the drag gesture is towards opening or closing
                    let shouldOpen = translation < 0
                    // Calculate the snap distance
                    let snapDistance = self.maxHeight * BottomSheetConstants.snapRatio
                    // Snap to open or close state based on the drag distance
                    if abs(translation) > snapDistance {
                        self.isOpen = shouldOpen
                    }
                }
            )
        }
    }
}

private enum BottomSheetConstants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 3.5
    static let indicatorWidth: CGFloat = 40
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
    static let defaultMinHeight: CGFloat = 210
    static let defaultMaxHeight: CGFloat = 300 // The value been chosen based on design requirements, ensuring that the maximum height of the bottom sheet fits well with the overall UI layout
}

struct WKBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(isOpen: .constant(false)) {
            Rectangle().fill(Color.green)
        }
        .ignoresSafeArea()
    }
}

