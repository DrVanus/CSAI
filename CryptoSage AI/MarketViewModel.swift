//
//  MarketViewModel.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import Foundation
import Combine

@available(iOS 16.0, *)
class MarketViewModel: ObservableObject {
    // List of market coins
    @Published var marketCoins: [CoinGeckoCoin] = []
    @Published var isLoading: Bool = false
    
    func fetchMarketCoins() {
        // Replace with your actual network code to fetch market coins.
        print("Fetching market coins…")
    }
}