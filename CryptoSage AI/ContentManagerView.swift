//
//  ContentManagerView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI
import WebKit
import Foundation
import Speech
import AVFoundation

// MARK: - Content Manager View

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
                .sheet(isPresented: Binding(get: { homeVM.showSettings },
                                             set: { homeVM.showSettings = $0 })) {
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
                AITabView()
            }
            
            // Custom bottom tab bar
            VStack {
                Spacer()
                CustomTabBar()
            }
        }
        .gesture(
            DragGesture().onChanged { _ in
                // Use our local safeEndEditing() extension
                UIApplication.shared.safeEndEditing()
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

// MARK: - Local UIApplication Extension for endEditing

#if canImport(UIKit)
extension UIApplication {
    func safeEndEditing() {
        #if targetEnvironment(macCatalyst)
        // On Mac Catalyst, do nothing to avoid errors.
        #else
        // On iOS devices, dismiss the keyboard.
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}
#endif
