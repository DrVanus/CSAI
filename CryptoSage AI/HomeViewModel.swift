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
    // Key property for toggling settings
    @Published var showSettings: Bool = false
    
    @Published var trendingCoins: [TrendingCoin] = []
    @Published var watchlistCoins: [CoinGeckoCoin] = []
    @Published var news: [NewsItem] = []
    
    func refreshWatchlistData() {
        // Placeholder
    }
    
    func fetchNews() {
        // Placeholder
    }
    
    func fetchTrending() {
        // Placeholder
    }
    
    func loadUserWallets() {
        // Placeholder
    }
}
