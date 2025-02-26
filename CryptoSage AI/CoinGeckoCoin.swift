//
//  CoinGeckoCoin.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct CoinGeckoCoin: Decodable, Identifiable {
    // Create an ID for SwiftUI; use the coinGeckoID for actual API purposes.
    let id = UUID()
    let coinGeckoID: String
    let symbol: String
    let name: String?
    let currentPrice: Double?
    let priceChangePercentage24h: Double?
    let high24h: Double?
    let low24h: Double?
    let totalVolume: Double?
    let marketCap: Double?
    let circulatingSupply: Double?
    
    enum CodingKeys: String, CodingKey {
        case coinGeckoID = "id"
        case symbol
        case name
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case high24h = "high_24h"
        case low24h  = "low_24h"
        case totalVolume = "total_volume"
        case marketCap   = "market_cap"
        case circulatingSupply = "circulating_supply"
    }
}

@available(iOS 16.0, *)
struct TrendingCoin: Identifiable {
    let id: String
    let symbol: String
    let price: Double
    let priceChange24h: Double
}

@available(iOS 16.0, *)
struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let source: String
    let url: URL?
}

@available(iOS 16.0, *)
struct UserWallet: Identifiable, Codable {
    let id = UUID()
    let address: String
    let label: String
}