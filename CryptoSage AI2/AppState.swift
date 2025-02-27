//
//  AppState.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
class AppState: ObservableObject {
    @Published var selectedTab: CustomTab = .home
    @Published var isDarkMode: Bool = true
}

@available(iOS 16.0, *)
enum CustomTab: String {
    case home      = "Home"
    case market    = "Market"
    case trade     = "Trade"
    case portfolio = "Portfolio"
    case ai        = "AI"
}