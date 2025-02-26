//
//  TradeViewModel.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import Foundation
import Combine

@available(iOS 16.0, *)
class TradeViewModel: ObservableObject {
    @Published var selectedSymbol: String = "BTC-USD"
    @Published var side: String = "Buy"          // "Buy" or "Sell"
    @Published var orderType: String = "Market"    // e.g. "Market", "Limit", etc.
    @Published var quantity: String = ""
    @Published var limitPrice: String = ""
    @Published var stopPrice: String = ""
    @Published var trailingStop: String = ""
    @Published var chartTimeframe: String = "60"   // e.g. "60" for 1 hour
    @Published var aiSuggestion: String = ""
    @Published var userBalance: Double = 5000.0
    
    func submitOrder() {
        // Simulate order submission and generate an AI suggestion.
        aiSuggestion = "AI Suggestion: For \(selectedSymbol), consider a trailing stop at \(trailingStop)."
    }
    
    func applyFraction(_ fraction: Double) {
        // Calculate quantity based on a fraction of the user's balance.
        // Use limitPrice if provided; otherwise use a fallback.
        let price = (Double(limitPrice) ?? 0) > 0 ? Double(limitPrice)! : 20000.0
        let amountToSpend = userBalance * fraction
        let coinQty = amountToSpend / price
        quantity = String(format: "%.4f", coinQty)
    }
}