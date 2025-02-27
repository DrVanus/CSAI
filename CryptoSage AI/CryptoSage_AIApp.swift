//
//  CryptoSage_AIApp.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@main
struct CryptoSage_AIApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentManagerView()
                .environmentObject(appState)
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
        }
    }
}
