//
//  CoinDetailView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct CoinDetailView: View {
    let coinSymbol: String
    let coinName: String
    let currentPrice: Double
    let change24h: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(coinName) (\(coinSymbol))")
                .font(.title)
                .bold()
            
            Text("Price: \(currentPrice, specifier: "%.2f") USD")
                .font(.headline)
            
            Text("24h Change: \(change24h >= 0 ? "+" : "")\(change24h, specifier: "%.2f")%")
                .foregroundColor(change24h >= 0 ? .green : .red)
            
            // Placeholder chart
            ZStack {
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                Text("Chart Placeholder")
                    .foregroundColor(.white)
            }
            .frame(height: 200)
            
            // Additional coin details
            Text("Detailed info about \(coinSymbol). Market cap, volume, supply, etc.")
                .font(.body)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(coinSymbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coinSymbol: "BTC", coinName: "Bitcoin", currentPrice: 29500, change24h: 3.5)
    }
}
