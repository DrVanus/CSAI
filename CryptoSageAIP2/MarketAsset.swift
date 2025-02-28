//
//  MarketAsset.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

// Data model
struct MarketAsset: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
    let change24h: Double
}

// View model
class MarketViewModel: ObservableObject {
    @Published var assets: [MarketAsset] = [
        MarketAsset(symbol: "BTC", name: "Bitcoin", price: 29500.0, change24h: 3.5),
        MarketAsset(symbol: "ETH", name: "Ethereum", price: 1850.75, change24h: -1.2),
        // ...
    ]
    
    func refreshMarketData() {
        // Real API calls or data updates
    }
}
