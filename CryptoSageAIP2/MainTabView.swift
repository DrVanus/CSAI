//
//  MainTabView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Home tab
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // Market tab
            MarketView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Market")
                }
            
            // Trade tab
            TradeView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Trade")
                }
            
            // Portfolio tab
            PortfolioView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Portfolio")
                }
            
            // AI Chat tab
            AIChatPageView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("AI")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
