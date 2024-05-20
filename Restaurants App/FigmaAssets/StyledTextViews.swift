//
//  StyledTextViews.swift
//
//  Created by Abhishek B on 2024-05-18.
//

import Foundation
import SwiftUI

struct StyledTextView: View {
    let textStyle: TextStyle
    let text: String

    @ObservedObject private var textStyleManager = TextStyleManager.shared

    var body: some View {
        if textStyleManager.textStyles[textStyle] != nil {
            Text(text)
        } else {
            Text(text)
                .foregroundColor(.gray)
        }
    }
}
