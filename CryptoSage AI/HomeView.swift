//
//  HomeView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var marketVM: MarketViewModel
    let tradeVM: TradeViewModel?
    let onOpenSettings: () -> Void
    
    @State private var userInput: String = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        heroSection
                        portfolioSummaryCard
                        trendingSection
                        watchlistSection
                        chatSection
                        newsSection
                        Spacer().frame(height: 80)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        onOpenSettings()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var heroSection: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .gray]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .cornerRadius(10)
            VStack {
                Text("Welcome to CryptoSage AI")
                    .font(.title2)
                    .foregroundColor(.white)
                Text("Your next-gen crypto tools")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
        .frame(height: 80)
    }
    
    var portfolioSummaryCard: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Portfolio Summary")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Total Value: $19,290.00")
                    .foregroundColor(.white)
                Text("24h Change: +2.83%")
                    .foregroundColor(.green)
                Button("View Full Portfolio") {
                    // Navigate to Portfolio tab if needed
                }
                .font(.subheadline)
                .padding(8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
    }
    
    var trendingSection: some View {
        Group {
            if !viewModel.trendingCoins.isEmpty {
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Trending")
                            .font(.headline)
                            .foregroundColor(.white)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.trendingCoins) { coin in
                                    TrendingCard(item: MarketItem(symbol: coin.symbol.uppercased(), price: coin.price, change: coin.priceChange24h))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var watchlistSection: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Watchlist")
                    .font(.headline)
                    .foregroundColor(.white)
                if viewModel.isLoadingCoins {
                    Text("Loading...")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.watchlistCoins) { coin in
                        NavigationLink(destination: CoinDetailView(coin: coin, homeVM: viewModel, tradeVM: tradeVM)) {
                            WatchlistRow(item: MarketItem(symbol: coin.symbol.uppercased(), price: coin.currentPrice ?? 0, change: coin.priceChangePercentage24h ?? 0))
                        }
                    }
                }
            }
        }
    }
    
    var chatSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("AI Chat")
                .font(.headline)
                .foregroundColor(.white)
            ForEach(viewModel.messages) { message in
                ChatBubble(message: message)
            }
            HStack {
                TextEditor(text: $userInput)
                    .frame(minHeight: 40, maxHeight: 80)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    .focused($isInputFocused)
                Button("Send") {
                    if !userInput.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.sendUserMessage(userInput)
                        userInput = ""
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
    
    var newsSection: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Latest Crypto News")
                    .font(.headline)
                    .foregroundColor(.white)
                if viewModel.isLoadingNews {
                    Text("Loading news...")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.news) { news in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(news.title)
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Text(news.source)
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        Divider().background(Color.gray)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(), marketVM: MarketViewModel(), tradeVM: TradeViewModel()) {
            print("Open Settings")
        }
    }
}
