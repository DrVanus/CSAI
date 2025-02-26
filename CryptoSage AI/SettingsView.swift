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
            // Insert your full Settings UI code here (toggles, pickers, etc.)
            Section(header: Text("General").foregroundColor(.white)) {
                Toggle("Enable Notifications", isOn: .constant(true))
                Toggle("Dark Mode On?", isOn: $appState.isDarkMode)
            }
            Section(header: Text("Price Alerts").foregroundColor(.white)) {
                Toggle("Enable Price Alerts", isOn: .constant(false))
                if false {
                    Text("Custom alerts will be available soon.")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            // Continue with the rest of your settings...
        }
        .background(Color.black)
        .foregroundColor(.white)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(HomeViewModel()).environmentObject(AppState())
    }
}