//
//  SettingsViewModel.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI
import Combine

/// A view model for user settings/preferences.
class SettingsViewModel: ObservableObject {
    @Published var notificationsEnabled: Bool = true
    @Published var defaultCurrency: String = "USD"
    @Published var darkModeEnabled: Bool = false
    
    /// Save or load settings as needed. 
    func toggleDarkMode() {
        darkModeEnabled.toggle()
        // In a real app, you'd also update the app’s color scheme or store the preference.
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Title (optional—remove or rename as desired)
            Text("Settings")
                .font(.headline)
                .padding(.top, 8)
            
            // Notifications toggle
            Toggle("Enable Notifications", isOn: $viewModel.notificationsEnabled)
                .padding(.horizontal)
            
            // Default currency picker
            HStack {
                Text("Default Currency:")
                Spacer()
                Picker("Default Currency", selection: $viewModel.defaultCurrency) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("GBP").tag("GBP")
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal)
            
            // Dark Mode toggle
            Toggle("Enable Dark Mode", isOn: $viewModel.darkModeEnabled)
                .padding(.horizontal)
                .onChange(of: viewModel.darkModeEnabled) { _ in
                    viewModel.toggleDarkMode()
                }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}