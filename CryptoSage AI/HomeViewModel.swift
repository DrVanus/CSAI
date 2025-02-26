//
//  HomeViewModel.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import Foundation
import Combine

@available(iOS 16.0, *)
class HomeViewModel: ObservableObject {
    // Trending coins shown in the Home tab
    @Published var trendingCoins: [TrendingCoin] = []
    
    // Coins for the watchlist
    @Published var watchlistCoins: [CoinGeckoCoin] = []
    
    // Latest news items
    @Published var news: [NewsItem] = []
    
    // Loading states
    @Published var isLoadingCoins: Bool = false
    @Published var isLoadingNews: Bool = false
    
    // User’s watchlist coin IDs (for example, initially preset)
    @Published var watchlistIDs: Set<String> = ["bitcoin", "ethereum", "solana"]
    
    // Wallets for portfolio support
    @Published var userWallets: [UserWallet] = []
    
    // MARK: - Methods (implementations should be replaced with your real code)
    
    func refreshWatchlistData() {
        // Your original code that fetches watchlist coins goes here.
        // For now, we leave this as a placeholder.
        print("Refreshing watchlist data…")
    }
    
    func fetchNews() {
        // Your code to fetch crypto news goes here.
        print("Fetching news…")
    }
    
    func fetchTrending() {
        // Your code to fetch trending coins goes here.
        print("Fetching trending coins…")
    }
    
    func loadUserWallets() {
        // Load wallets from UserDefaults (or wherever you stored them)
        guard let data = UserDefaults.standard.data(forKey: "userWalletsData") else { return }
        do {
            let decoded = try JSONDecoder().decode([UserWallet].self, from: data)
            DispatchQueue.main.async {
                self.userWallets = decoded
            }
        } catch {
            print("Error decoding wallets: \(error)")
        }
    }
    
    func addToWatchlist(coinID: String) {
        watchlistIDs.insert(coinID)
    }
    
    func removeFromWatchlist(coinID: String) {
        watchlistIDs.remove(coinID)
    }
}