//
//  CoinGeckoCoin.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import Foundation

struct CoinGeckoCoin: Decodable, Identifiable {
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

struct Holding: Identifiable, Codable {
    let id = UUID()
    var symbol: String
    var amount: Double
    var totalValue: Double
    var dailyChangePercent: Double
}

struct MarketItem: Identifiable {
    let id = UUID()
    let symbol: String
    let price: Double
    let change: Double
}

struct UserWallet: Identifiable, Codable {
    let id = UUID()
    let address: String
    let label: String
}
