//
//  ColorsAndStyles.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

extension Color {
    // Existing brand colors
    static let brandPrimary = Color.purple
    static let brandSecondary = Color.orange
    
    // Create a slightly darker variant of brandPrimary for the tile gradient
    // (If you want more subtlety, tweak the multipliers.)
    static let brandPrimaryDark = Color(
        red: 0.8 * 0.5,  // Adjust as needed
        green: 0.0,
        blue: 0.8 * 0.5
    )
}

// MARK: - Button Styles

/// A “luxury” button style with a gold→purple gradient background
struct LuxuryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.85, green: 0.72, blue: 0.53), // gold
                        .brandPrimary
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(10)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

/// Slight scale on press
struct ScaleOnPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
