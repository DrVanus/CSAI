//
//  HomeView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var marketVM: MarketViewModel
    let tradeVM: TradeViewModel?
    let onOpenSettings: () -> Void
    
    @State private var showNewsWeb = false
    @State private var newsURL: URL? = nil
    @State private var trendingDetailCoin: CoinGeckoCoin? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 12) {
                        heroSection
                        portfolioSummaryCard
                        trendingSection
                        watchlistSection
                        topGainersSection
                        newsSection
                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .refreshable {
                    viewModel.refreshWatchlistData()
                    viewModel.fetchNews()
                    viewModel.fetchTrending()
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { onOpenSettings() } label: {
                        Image(systemName: "gearshape.fill").foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showNewsWeb) {
                if let url = newsURL {
                    NewsWebView(url: url)
                } else {
                    Text("No URL to load.")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                }
            }
            .sheet(item: $trendingDetailCoin) { coin in
                CoinDetailView(coin: coin, homeVM: viewModel, tradeVM: tradeVM)
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
            VStack(spacing: 4) {
                Text("Welcome to CryptoSage AI")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                Text("Your Next-Gen Crypto Tools")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.vertical, 16)
        }
        .frame(height: 80)
    }
    
    var portfolioSummaryCard: some View {
        // Your portfolio summary UI from your original file
        CardView(cornerRadius: 6, paddingAmount: 8) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your Portfolio Summary")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Total Value: $19290.00")
                    .foregroundColor(.white)
                Text("24h Change: +2.83%")
                    .foregroundColor(.green)
                Button {
                    appState.selectedTab = .portfolio
                } label: {
                    Text("View Full Portfolio")
                        .font(.subheadline)
                        .padding(6)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
    
    var trendingSection: some View {
        Group {
            if !viewModel.trendingCoins.isEmpty {
                CardView(cornerRadius: 6, paddingAmount: 4) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Trending")
                            .font(.headline)
                            .foregroundColor(.white)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.trendingCoins) { tcoin in
                                    Button {
                                        viewModel.fetchCoinByID(tcoin.id) { fetchedCoin in
                                            DispatchQueue.main.async {
                                                if let realCoin = fetchedCoin {
                                                    trendingDetailCoin = realCoin
                                                }
                                            }
                                        }
                                    } label: {
                                        TrendingCard(item: MarketItem(symbol: tcoin.symbol.uppercased(), price: tcoin.price, change: tcoin.priceChange24h))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var watchlistSection: some View {
        CardView(cornerRadius: 6, paddingAmount: 4) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your Watchlist")
                    .font(.headline)
                    .foregroundColor(.white)
                Divider().background(Color.gray)
                if viewModel.isLoadingCoins {
                    Text("Loading coin prices...")
                        .foregroundColor(.gray)
                } else {
                    if viewModel.watchlistCoins.isEmpty {
                        Text("No watchlist coins found.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(viewModel.watchlistCoins.indices, id: \.self) { index in
                            let coin = viewModel.watchlistCoins[index]
                            NavigationLink {
                                CoinDetailView(coin: coin, homeVM: viewModel, tradeVM: tradeVM)
                            } label: {
                                VStack {
                                    WatchlistRow(item: MarketItem(symbol: coin.symbol.uppercased(), price: coin.currentPrice ?? 0, change: coin.priceChangePercentage24h ?? 0))
                                    Divider().background(Color.gray.opacity(0.4))
                                }
                                .padding(.vertical, 1)
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModel.removeFromWatchlist(coinID: coin.coinGeckoID)
                                    viewModel.refreshWatchlistData()
                                } label: {
                                    Label("Remove from Watchlist", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var topGainersSection: some View {
        CardView(cornerRadius: 6, paddingAmount: 4) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Top Gainers")
                    .font(.headline)
                    .foregroundColor(.white)
                Divider().background(Color.gray)
                let topGainers = marketVM.marketCoins.sorted { ($0.priceChangePercentage24h ?? 0) > ($1.priceChangePercentage24h ?? 0) }.prefix(3)
                if topGainers.isEmpty {
                    Text("No data yet.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(topGainers) { coin in
                        VStack {
                            WatchlistRow(item: MarketItem(symbol: coin.symbol.uppercased(), price: coin.currentPrice ?? 0, change: coin.priceChangePercentage24h ?? 0))
                            Divider().background(Color.gray.opacity(0.4))
                        }
                        .padding(.vertical, 1)
                    }
                }
            }
        }
    }
    
    var newsSection: some View {
        CardView(cornerRadius: 6, paddingAmount: 4) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Latest Crypto News (In-App)")
                    .font(.headline)
                    .foregroundColor(.white)
                if viewModel.isLoadingNews {
                    Text("Loading news...")
                        .foregroundColor(.gray)
                } else {
                    if viewModel.news.isEmpty {
                        Text("No news found.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(viewModel.news) { news in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(news.title)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                HStack {
                                    Text(news.source)
                                        .foregroundColor(.gray)
                                        .font(.footnote)
                                    Spacer()
                                    if let url = news.url, !url.absoluteString.isEmpty {
                                        Button("Read More") {
                                            newsURL = url
                                            showNewsWeb = true
                                        }
                                        .foregroundColor(.blue)
                                        .font(.footnote)
                                    } else {
                                        Text("No link available")
                                            .foregroundColor(.gray)
                                            .font(.footnote)
                                    }
                                }
                            }
                            Divider().background(Color.gray.opacity(0.4))
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userApiKey: .constant("TEST_API_KEY"), modelType: .constant("gpt-3.5-turbo"))
            .environmentObject(AppState())
    }
}