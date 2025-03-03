//
//  TopWaveShape.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct TopWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Start at the top-left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        // Draw a gentle curve across the top
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control1: CGPoint(x: rect.width * 0.25, y: rect.minY + 40),
            control2: CGPoint(x: rect.width * 0.75, y: rect.minY - 40)
        )
        // Draw lines down and back to complete the shape
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct TopWaveShape_Previews: PreviewProvider {
    static var previews: some View {
        TopWaveShape()
            .fill(Color.blue)
            .frame(height: 160)
            .previewLayout(.sizeThatFits)
    }
}