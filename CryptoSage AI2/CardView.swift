//
//  CardView.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct CardView<Content: View>: View {
    let content: Content
    var cornerRadius: CGFloat = 8
    var paddingAmount: CGFloat = 8
    
    init(cornerRadius: CGFloat = 8,
         paddingAmount: CGFloat = 8,
         @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.paddingAmount = paddingAmount
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding(paddingAmount)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.white.opacity(0.05), .white.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(cornerRadius)
        .shadow(color: .white.opacity(0.15), radius: 3, x: 0, y: 2)
    }
}
