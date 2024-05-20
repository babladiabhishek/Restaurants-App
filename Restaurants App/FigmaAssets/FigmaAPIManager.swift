//
//  FigmaAPIManager.swift
//
//  Created by Abhishek B on 2024-05-18.
//

import Foundation
import SwiftUI

class FigmaAPIManager: ObservableObject {
    static let shared = FigmaAPIManager()

    @Published var textStyles: [TextStyle: Font] = [:]
    @Published var colors: [AppColors: Color] = [:]

    private init() {
        fetchFigmaData()
    }

    func fetchFigmaData() {
        let accessToken = "figd_x6RRfijxrgkdtcx7U-_fNDDbv661rSE1CtRhEe8N" // Replace with your Figma access token
        let fileKey = "cieUHtlRMwZrrOCuehBjf7" // Extracted from the URL
        let textStyleNodeId = "305:103" // Node ID for text styles
        let colorNodeId = "305:110" // Node ID for colors

        let url = URL(string: "https://api.figma.com/v1/files/\(fileKey)/nodes?ids=\(textStyleNodeId),\(colorNodeId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(accessToken, forHTTPHeaderField: "X-FIGMA-TOKEN")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                print("Error: No data")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 403 {
                    print("Error: Forbidden - Check your access token and permissions")
                    return
                }
            }

            do {
                let responseString = String(data: data, encoding: .utf8)
                print("Response data: \(responseString ?? "No response data")")

                let decodedData = try JSONDecoder().decode(FigmaNodeResponse.self, from: data)
                if let textStyleNode = decodedData.nodes[textStyleNodeId]?.document {
                    self?.extractTextStyles(from: textStyleNode)
                }
                if let colorNode = decodedData.nodes[colorNodeId]?.document {
                    self?.extractColors(from: colorNode)
                }

                DispatchQueue.main.async {
                    self?.textStyles = self?.extractedTextStyles ?? [:]
                    self?.colors = self?.extractedColors ?? [:]
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }

    private var extractedTextStyles: [TextStyle: Font] = [:]
    private var extractedColors: [AppColors: Color] = [:]

    private func extractTextStyles(from node: FigmaNode, parentName: String? = nil) {
        if let style = node.style, let font = fontFromFigmaStyle(style: style) {
            let nodeName = parentName ?? node.name
            if let textStyle = TextStyle(rawValue: nodeName) {
                extractedTextStyles[textStyle] = font
            }
        }

        if let children = node.children {
            for child in children {
                let newName = (child.name == "Text") ? (parentName ?? node.name) : child.name
                extractTextStyles(from: child, parentName: newName)
            }
        }
    }

    private func extractColors(from node: FigmaNode, parentName: String? = nil) {
        let nodeName = parentName ?? node.name
        if let appColor = AppColors(rawValue: nodeName) {
            if let fills = node.fills {
                for fill in fills {
                    if let color = fill.color {
                        let frameColor = Color(red: Double(color.r), green: Double(color.g), blue: Double(color.b), opacity: Double(color.a))
                        extractedColors[appColor] = frameColor
                        return
                    }
                }
            }
        }

        if let children = node.children {
            for child in children {
                let newName = (child.name == "Ellipse 1") ? (parentName ?? node.name) : child.name
                extractColors(from: child, parentName: newName)
            }
        }
    }

    private func fontFromFigmaStyle(style: FigmaTextStyle) -> Font? {
        guard let fontSize = style.fontSize else { return nil }
        let weight: Font.Weight = fontWeight(from: style.fontWeight)
        return Font.system(size: CGFloat(fontSize), weight: weight)
    }

    private func fontWeight(from fontWeight: FontWeight?) -> Font.Weight {
        guard let fontWeight = fontWeight else { return .regular }
        switch fontWeight {
        case .number(let value):
            return fontWeightFromNumber(value)
        case .string(let value):
            return fontWeightFromString(value)
        }
    }

    private func fontWeightFromNumber(_ value: Int) -> Font.Weight {
        switch value {
        case 100: return .ultraLight
        case 200: return .thin
        case 300: return .light
        case 400: return .regular
        case 500: return .medium
        case 600: return .semibold
        case 700: return .bold
        case 800: return .heavy
        case 900: return .black
        default: return .regular
        }
    }

    private func fontWeightFromString(_ value: String) -> Font.Weight {
        switch value.lowercased() {
        case "ultralight": return .ultraLight
        case "thin": return .thin
        case "light": return .light
        case "regular": return .regular
        case "medium": return .medium
        case "semibold": return .semibold
        case "bold": return .bold
        case "heavy": return .heavy
        case "black": return .black
        default: return .regular
        }
    }
}
