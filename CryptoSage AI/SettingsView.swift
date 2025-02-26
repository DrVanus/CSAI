//
//  SettingsView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Form {
            Section(header: Text("General").foregroundColor(.white)) {
                Toggle("Dark Mode", isOn: $appState.isDarkMode)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .foregroundColor(.white)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(HomeViewModel())
            .environmentObject(AppState())
    }
}
