//
//  WatchlistRow.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct WatchlistRow: View {
    let item: MarketItem
    
    var body: some View {
        HStack {
            Text(item.symbol)
                .foregroundColor(.white)
                .font(.headline)
            Spacer()
            Text("$\(formatPrice(item.price, symbol: item.symbol))")
                .foregroundColor(.white)
            let sign = item.change >= 0 ? "+" : ""
            Text("\(sign)\(item.change, specifier: "%.2f")%")
                .foregroundColor(item.change >= 0 ? .green : .red)
                .padding(.leading, 6)
        }
        .padding(.vertical, 4)
    }
    
    func formatPrice(_ price: Double, symbol: String) -> String {
        let upper = symbol.uppercased()
        if upper.contains("BTC") || upper.contains("ETH") || upper.contains("SOL") {
            return String(format: "%.2f", price)
        } else {
            return String(format: "%.4f", price)
        }
    }
}
