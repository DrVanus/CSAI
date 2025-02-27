//
//  TrendingCard.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct TrendingCard: View {
    let item: MarketItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.symbol)
                .font(.headline)
                .foregroundColor(.white)
            Text("$\(item.price, specifier: "%.8f")")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            let sign = item.change >= 0 ? "+" : ""
            Text("\(sign)\(item.change, specifier: "%.2f")%")
                .font(.footnote)
                .foregroundColor(item.change >= 0 ? .green : .red)
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(item.change >= 0 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
        )
    }
}
