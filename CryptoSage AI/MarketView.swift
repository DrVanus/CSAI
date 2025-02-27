//
//  MarketView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct MarketView: View {
    @ObservedObject var marketVM: MarketViewModel
    @ObservedObject var homeVM: HomeViewModel
    let tradeVM: TradeViewModel?
    
    @State private var searchText = ""
    @State private var sortOption: MarketSortOption = .name
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 12) {
                        // watchers/disclaimers toggles if needed
                        Toggle("Include Solana?", isOn: .constant(false))
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        // Search & Sort UI
                        searchAndSortControls
                        
                        if marketVM.isLoading {
                            Text("Loading market data...")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            let filteredCoins = filterCoins(marketVM.marketCoins)
                            let sortedCoins = sortCoins(filteredCoins)
                            
                            if sortedCoins.isEmpty {
                                Text("No coins match your search.")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                marketHeader()
                                
                                ForEach(sortedCoins, id: \.coinGeckoID) { coin in
                                    // Break up big expressions:
                                    let detailView = CoinDetailView(coin: coin, homeVM: homeVM, tradeVM: tradeVM)
                                    let rowView = MarketRowView(coin: coin, homeVM: homeVM)
                                    
                                    NavigationLink(destination: detailView) {
                                        rowView
                                    }
                                    // watchers disclaimers or remove from watchlist in context menu
                                    .contextMenu {
                                        Button("Remove from Watchlist") {
                                            // IMPORTANT: No "$homeVM" or binding usage—just call the function
                                            homeVM.removeFromWatchlist(coinID: coin.coinGeckoID)
                                            homeVM.refreshWatchlistData()
                                        }
                                    }
                                }
                            }
                            Spacer().frame(height: 80)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .refreshable {
                    marketVM.fetchMarketCoins()
                }
            }
            .navigationBarTitle("Market", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Search & Sort Controls
    private var searchAndSortControls: some View {
        HStack {
            TextField("Search coins...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
            Spacer()
            Menu("Sort By") {
                Button("Name") { sortOption = .name }
                Button("Price") { sortOption = .price }
                Button("24h %") { sortOption = .change }
            }
            .padding(.trailing, 8)
            .foregroundColor(.white)
        }
    }
    
    // MARK: - Filter
    private func filterCoins(_ coins: [CoinGeckoCoin]) -> [CoinGeckoCoin] {
        coins.filter { coin in
            searchText.isEmpty ||
            coin.symbol.lowercased().contains(searchText.lowercased()) ||
            (coin.name?.lowercased().contains(searchText.lowercased()) ?? false)
        }
    }
    
    // MARK: - Sort
    private func sortCoins(_ coins: [CoinGeckoCoin]) -> [CoinGeckoCoin] {
        switch sortOption {
        case .name:
            return coins.sorted { ($0.name ?? "") < ($1.name ?? "") }
        case .price:
            return coins.sorted { ($0.currentPrice ?? 0) > ($1.currentPrice ?? 0) }
        case .change:
            return coins.sorted { ($0.priceChangePercentage24h ?? 0) > ($1.priceChangePercentage24h ?? 0) }
        }
    }
    
    // MARK: - Header
    private func marketHeader() -> some View {
        HStack {
            Text("Fav")
                .foregroundColor(.gray)
                .frame(width: 32)
            Text("Coin")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Price")
                .foregroundColor(.gray)
                .frame(width: 70, alignment: .trailing)
            Text("24h")
                .foregroundColor(.gray)
                .frame(width: 50, alignment: .trailing)
        }
        .padding(.vertical, 4)
        .background(Color.black)
        .overlay(Divider().background(Color.gray), alignment: .bottom)
    }
}

// MARK: - MarketRowView Subview
private struct MarketRowView: View {
    let coin: CoinGeckoCoin
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: homeVM.watchlistIDs.contains(coin.coinGeckoID) ? "star.fill" : "star")
                .foregroundColor(homeVM.watchlistIDs.contains(coin.coinGeckoID) ? .yellow : .gray)
                .frame(width: 32)
                .onTapGesture {
                    if homeVM.watchlistIDs.contains(coin.coinGeckoID) {
                        homeVM.removeFromWatchlist(coinID: coin.coinGeckoID)
                    } else {
                        homeVM.addToWatchlist(coinID: coin.coinGeckoID)
                    }
                    homeVM.refreshWatchlistData()
                }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(coin.symbol.uppercased())
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text(coin.name ?? "")
                    .foregroundColor(.gray)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("$\(coin.currentPrice ?? 0, specifier: "%.2f")")
                .foregroundColor(.white)
                .frame(width: 70, alignment: .trailing)
            
            let change = coin.priceChangePercentage24h ?? 0
            Text("\(change >= 0 ? "+" : "")\(change, specifier: "%.2f")%")
                .foregroundColor(change >= 0 ? .green : .red)
                .frame(width: 50, alignment: .trailing)
        }
        .padding(.vertical, 4)
        .background(Color.black)
        .overlay(Divider().background(Color.gray.opacity(0.4)), alignment: .bottom)
    }
}

// MARK: - Sort Options
enum MarketSortOption {
    case name, price, change
}
