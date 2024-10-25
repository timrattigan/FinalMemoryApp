// Utilities/ViewModifiers.swift
import SwiftUI

struct MenuButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.headline)
    }
}

struct ResponseButtonStyle: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.headline)
    }
}
