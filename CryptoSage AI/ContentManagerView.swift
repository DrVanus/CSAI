//
//  ContentManagerView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct ContentManagerView: View {
    @EnvironmentObject var appState: AppState
    
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var marketVM = MarketViewModel()
    @StateObject private var tradeVM = TradeViewModel()
    
    var body: some View {
        ZStack {
            switch appState.selectedTab {
            case .home:
                HomeView(viewModel: homeVM, marketVM: marketVM, tradeVM: tradeVM) {
                    homeVM.showSettings.toggle()
                }
                .sheet(isPresented: Binding(get: { homeVM.showSettings }, set: { homeVM.showSettings = $0 })) {
                    NavigationView {
                        SettingsView()
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
                AITabView(homeVM: homeVM)
            }
            
            VStack {
                Spacer()
                CustomTabBar()
            }
        }
        .gesture(
            DragGesture().onChanged { _ in
                UIApplication.shared.endEditing()
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

struct ContentManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentManagerView().environmentObject(AppState())
    }
}
