//
//  HomeViewModel.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var showSettings: Bool = false
    
    @Published var trendingCoins: [TrendingCoin] = []
    @Published var watchlistCoins: [CoinGeckoCoin] = []
    @Published var news: [NewsItem] = []
    
    @Published var isLoadingCoins: Bool = false
    @Published var isLoadingNews: Bool = false
    
    // User’s watchlist IDs
    @Published var watchlistIDs: Set<String> = ["bitcoin", "ethereum", "solana"]
    
    // For portfolio wallets
    @Published var userWallets: [UserWallet] = []
    
    // For AI chat conversation
    @Published var messages: [ChatMessage] = [
        ChatMessage(role: .system, content: "Welcome to CryptoSage AI! Ask anything about crypto.")
    ]
    
    // For watchers disclaimers placeholders
    func loadUserWallets() {
        // ...
    }
    func saveUserWallets() {
        // ...
    }
    
    func refreshWatchlistData() {
        print("Refreshing watchlist data...")
    }
    func fetchNews() {
        print("Fetching news...")
    }
    func fetchTrending() {
        print("Fetching trending coins...")
    }
    
    // Watchlist
    func addToWatchlist(coinID: String) {
        watchlistIDs.insert(coinID)
    }
    func removeFromWatchlist(coinID: String) {
        watchlistIDs.remove(coinID)
    }
    
    // AI Chat
    func sendUserMessage(_ text: String) {
        let userMsg = ChatMessage(role: .user, content: text)
        messages.append(userMsg)
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let response = ChatMessage(role: .assistant, content: "Simulated response for: \(text)")
            self.messages.append(response)
        }
    }
}
