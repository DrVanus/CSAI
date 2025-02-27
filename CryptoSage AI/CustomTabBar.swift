//
//  CustomTabBar.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct CustomTabBar: View {
    @EnvironmentObject var appState: AppState
    let tabs: [CustomTab] = [.home, .market, .trade, .portfolio, .ai]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                Button(action: { appState.selectedTab = tab }) {
                    VStack(spacing: 2) {
                        Image(systemName: iconName(for: tab))
                            .font(.system(size: 18, weight: .semibold))
                        Text(tab.rawValue).font(.caption2)
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
    
    func iconName(for tab: CustomTab) -> String {
        switch tab {
        case .home:      return "house.fill"
        case .market:    return "chart.bar.xaxis"
        case .trade:     return "arrow.left.arrow.right.circle.fill"
        case .portfolio: return "chart.pie.fill"
        case .ai:        return "sparkles"
        }
    }
}
