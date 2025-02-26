//
//  MarketItem.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import Foundation

struct MarketItem: Identifiable {
    let id = UUID()
    let symbol: String
    let price: Double
    let change: Double
}