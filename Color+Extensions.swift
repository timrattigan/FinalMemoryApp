// Utilities/Color+Extensions.swift
import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "#1D3557")       // Dark Blue
    static let accentColor = Color(hex: "#E63946")        // Red
    static let backgroundColor = Color(hex: "#F1FAEE")    // Light Mint
    static let textColor = Color(hex: "#1D3557")          // Dark Blue
    static let secondaryTextColor = Color(hex: "#457B9D") // Medium Blue

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        // Skip '#' character if present
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255
        let blue = Double(rgbValue & 0x0000FF) / 255

        self.init(red: red, green: green, blue: blue)
    }
}
