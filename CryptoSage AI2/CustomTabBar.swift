//
//  CustomTabBar.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct CustomTabBar: View {
    @EnvironmentObject var appState: AppState
    let tabs: [CustomTab] = [.home, .market, .trade, .portfolio, .ai]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                Button(action: { appState.selectedTab = tab }) {
                    VStack(spacing: 2) {
                        switch tab {
                        case .home:
                            Image(systemName: "house.fill")
                                .font(.system(size: 18, weight: .semibold))
                            Text(tab.rawValue).font(.caption2)
                        case .market:
                            Image(systemName: "chart.bar.xaxis")
                                .font(.system(size: 18, weight: .semibold))
                            Text(tab.rawValue).font(.caption2)
                        case .trade:
                            Image(systemName: "arrow.left.arrow.right.circle.fill")
                                .font(.system(size: 18, weight: .semibold))
                            Text(tab.rawValue).font(.caption2)
                        case .portfolio:
                            Image(systemName: "chart.pie.fill")
                                .font(.system(size: 18, weight: .semibold))
                            Text(tab.rawValue).font(.caption2)
                        case .ai:
                            Image(systemName: "sparkles")
                                .font(.system(size: 18, weight: .semibold))
                            Text(tab.rawValue).font(.caption2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(appState.selectedTab == tab ? .blue : .gray)
                }
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 16)
        .background(Color.black.opacity(0.9))
    }
}
