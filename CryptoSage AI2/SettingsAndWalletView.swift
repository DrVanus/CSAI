//
//  SettingsView.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var appState: AppState
    
    @State private var notificationsEnabled = true
    @State private var autoDarkMode = true
    @State private var connectedExchanges: [String] = []
    
    @State private var selectedCurrency = "USD"
    @State private var aiTuning = "Conservative"
    
    @State private var showLinkSheet = false
    
    @State private var priceAlertsEnabled = false
    @State private var showAdvancedExchange = false
    
    // AI personality slider (placeholder)
    @State private var aiPersonality: Double = 0.5
    
    var body: some View {
        Form {
            Section(header: Text("General").foregroundColor(.white)) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                Toggle("Dark Mode On?", isOn: $appState.isDarkMode)
            }
            
            Section(header: Text("Price Alerts").foregroundColor(.white)) {
                Toggle("Enable Price Alerts", isOn: $priceAlertsEnabled)
                    .foregroundColor(.white)
                if priceAlertsEnabled {
                    Text("You can configure custom alerts in the future.")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            
            Section(header: Text("Preferences").foregroundColor(.white)) {
                Picker("Currency Preference", selection: $selectedCurrency) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("BTC").tag("BTC")
                }
                .pickerStyle(.segmented)
                
                Picker("AI Trading Style", selection: $aiTuning) {
                    Text("Aggressive").tag("Aggressive")
                    Text("Conservative").tag("Conservative")
                }
                .pickerStyle(.segmented)
                
                VStack(alignment: .leading) {
                    Text("AI Personality").foregroundColor(.white)
                    Slider(value: $aiPersonality, in: 0.0...1.0, step: 0.1)
                    Text("Value: \(aiPersonality, specifier: "%.1f") (placeholder)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Connected Exchanges").foregroundColor(.white)) {
                if connectedExchanges.isEmpty {
                    Text("No exchanges linked.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(connectedExchanges, id: \.self) { ex in
                        Text(ex)
                    }
                }
                
                Button {
                    showLinkSheet = true
                } label: {
                    HStack {
                        Image(systemName: "link")
                        Text("Link New Exchange")
                    }
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(8)
                }
            }
            
            Section(header: Text("Advanced Exchange Settings").foregroundColor(.white)) {
                Toggle("Show Advanced Exchange Options", isOn: $showAdvancedExchange)
                if showAdvancedExchange {
                    Text("Future expansions: real trading, API key usage, etc.")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            
            Section(header: Text("Wallets").foregroundColor(.white)) {
                NavigationLink(destination: WalletsView().environmentObject(homeVM)) {
                    Text("Manage Wallets")
                }
            }
            
            Section(footer:
                Text("Additional preferences can go here, like region, advanced AI settings, etc.")
                    .foregroundColor(.gray)
            ) {
                EmptyView()
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .foregroundColor(.white)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showLinkSheet) {
            LinkExchangeView { newExchange in
                connectedExchanges.append(newExchange)
            }
        }
    }
}

@available(iOS 16.0, *)
struct LinkExchangeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var exchangeName = ""
    @State private var apiKey = ""
    @State private var apiSecret = ""
    
    let onLink: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exchange Info")) {
                    TextField("Exchange Name", text: $exchangeName)
                    TextField("API Key", text: $apiKey)
                    SecureField("API Secret", text: $apiSecret)
                }
                
                Button("Link Exchange") {
                    guard !exchangeName.isEmpty else { return }
                    onLink(exchangeName)
                    dismiss()
                }
                .foregroundColor(.white)
                .padding(8)
                .background(Color.green.opacity(0.8))
                .cornerRadius(8)
            }
            .navigationTitle("Link Exchange")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// watchers disclaimers for wallets
struct UserWallet: Identifiable, Codable {
    let id = UUID()
    let address: String
    let label: String
}

@available(iOS 16.0, *)
struct WalletsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State private var newLabel   = ""
    @State private var newAddress = ""
    
    var body: some View {
        VStack {
            Text("Your Wallets")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            if homeVM.userWallets.isEmpty {
                Text("No wallets yet.")
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            } else {
                List {
                    ForEach(homeVM.userWallets) { w in
                        VStack(alignment: .leading) {
                            Text(w.label)
                                .foregroundColor(.white)
                                .font(.headline)
                            Text(w.address)
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            print("Tapped wallet: \(w.address)")
                        }
                    }
                    .onDelete { indexSet in
                        homeVM.userWallets.remove(atOffsets: indexSet)
                        homeVM.saveUserWallets()
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.black)
            }
            
            HStack {
                TextField("Label", text: $newLabel)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                
                TextField("Address", text: $newAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Add") {
                    guard !newAddress.isEmpty else { return }
                    let wallet = UserWallet(address: newAddress, label: newLabel.isEmpty ? "Wallet" : newLabel)
                    homeVM.userWallets.append(wallet)
                    homeVM.saveUserWallets()
                    
                    newAddress = ""
                    newLabel   = ""
                }
                .padding(6)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        .background(Color.black)
        .navigationTitle("Manage Wallets")
        .navigationBarTitleDisplayMode(.inline)
    }
}