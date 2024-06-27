//
//  SheetView.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import SwiftUI

struct SheetView<Content: View>: View {
    // MARK: - PROPERTIES

    var isPresented: Binding<Bool>
    var sheetHeight: Binding<CGFloat>
    var content: () -> Content

    // MARK: - BODY

    var body: some View {
        if #available(iOS 16.0, *) {
            content().fixedInnerHeight(sheetHeight)
        } else {
            VStack {
                Capsule()
                    .fill(Color.secondary)
                    .frame(width: 32, height: 4)
                    .padding(.top, 10)
                    .onTapGesture {
                        isPresented.wrappedValue.toggle()
                    }

                content()

                Spacer()
            }
        }
    }
}

// MARK: - PREVIEW

struct SheetView_Previews: PreviewProvider {
    @State static var isPresented: Bool = true
    @State static var sheetHeight: CGFloat = .zero

    static var previews: some View {
        SheetView(isPresented: $isPresented, sheetHeight: $sheetHeight) {
            MoreInformationView()
        }
    }
}
