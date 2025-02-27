//
//  CoinDetailView.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct CoinDetailView: View {
    let coin: CoinGeckoCoin
    @ObservedObject var homeVM: HomeViewModel
    var tradeVM: TradeViewModel? = nil
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("Coin Detail for \(coin.symbol.uppercased()) (Placeholder)")
                .foregroundColor(.white)
        }
        .navigationTitle(coin.name ?? coin.symbol.uppercased())
        .navigationBarTitleDisplayMode(.inline)
    }
}
