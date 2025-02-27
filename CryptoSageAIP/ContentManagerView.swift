//
//  ContentManagerView.swift
//  CryptoSageAIP
//
//  Created by DM on 2/27/25.
//


import SwiftUI

struct ContentManagerView: View {
    @EnvironmentObject var appState: AppState

    @StateObject private var homeVM   = HomeViewModel()
    @StateObject private var marketVM = MarketViewModel()
    @StateObject private var tradeVM  = TradeViewModel()

    var body: some View {
        ZStack {
            switch appState.selectedTab {
            case .home:
                HomeView(viewModel: homeVM, marketVM: marketVM, tradeVM: tradeVM) {
                    homeVM.showSettings.toggle()
                }
                .sheet(isPresented: $homeVM.showSettings) {
                    NavigationView {
                        SettingsAndWalletView()
                            .environmentObject(homeVM)
                            .environmentObject(appState)
                    }
                    .presentationDetents([.medium, .large])
                }

            case .market:
                MarketView(marketVM: marketVM, homeVM: homeVM, tradeVM: tradeVM)

            case .trade:
                TradeView(tradeVM: tradeVM)

            case .portfolio:
                PortfolioView()

            case .ai:
                AITabView()
            }

            VStack {
                Spacer()
                CustomTabBar()
            }
        }
        .gesture(
            DragGesture().onChanged { _ in
                // UIApplication.shared.endEditing()
            }
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            homeVM.refreshWatchlistData()
            homeVM.fetchNews()
            homeVM.fetchTrending()
            marketVM.fetchMarketCoins()
            homeVM.loadUserWallets()
        }
    }
}
