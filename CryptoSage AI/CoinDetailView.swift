//
//  CoinDetailView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct CoinDetailView: View {
    let coin: CoinGeckoCoin
    @ObservedObject var homeVM: HomeViewModel
    let tradeVM: TradeViewModel?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Text("\(coin.symbol.uppercased()) Details")
                    .font(.title2)
                    .foregroundColor(.white)
                if let name = coin.name {
                    Text("Name: \(name)")
                        .foregroundColor(.white)
                }
                Text("Current Price: $\(coin.currentPrice ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                Text("24h Change: \(coin.priceChangePercentage24h ?? 0, specifier: "%.2f")%")
                    .foregroundColor((coin.priceChangePercentage24h ?? 0) >= 0 ? .green : .red)
                
                // watchers disclaimers placeholders
                Text("High: \(coin.high24h ?? 0, specifier: "%.2f"), Low: \(coin.low24h ?? 0, specifier: "%.2f")")
                    .foregroundColor(.white)
                
                if let tradeVM = tradeVM {
                    Button("Trade \(coin.symbol.uppercased())") {
                        // Possibly set tradeVM.selectedSymbol, etc.
                        tradeVM.selectedSymbol = "\(coin.symbol.uppercased())-USD"
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("\(coin.symbol.uppercased())", displayMode: .inline)
    }
}
