//
//  CryptoSageAIApp.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
@main
struct CryptoSageAIApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentManagerView()
                .environmentObject(appState)
                // Keep dark mode by default
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
        }
    }
}