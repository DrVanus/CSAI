//
//  CoinGeckoCoin.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import Foundation

// Minimal placeholders
struct CoinGeckoCoin: Identifiable {
    let id = UUID()
    let symbol: String
    let currentPrice: Double?
    let priceChangePercentage24h: Double?
}

struct TrendingCoin: Identifiable {
    let id = UUID()
    let symbol: String
    let price: Double
    let priceChange24h: Double
}

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let source: String
    let url: URL?
}

struct UserWallet: Identifiable, Codable {
    let id = UUID()
    let address: String
    let label: String
}
