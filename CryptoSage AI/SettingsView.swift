//
//  SettingsView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var appState: AppState
    
    @State private var notificationsEnabled = true
    
    var body: some View {
        Form {
            Section(header: Text("General").foregroundColor(.white)) {
                Toggle("Dark Mode", isOn: $appState.isDarkMode)
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
            }
            Section(header: Text("Wallets").foregroundColor(.white)) {
                NavigationLink(destination: WalletsView().environmentObject(homeVM)) {
                    Text("Manage Wallets")
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .foregroundColor(.white)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

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
                    ForEach(homeVM.userWallets) { wallet in
                        VStack(alignment: .leading) {
                            Text(wallet.label)
                                .foregroundColor(.white)
                                .font(.headline)
                            Text(wallet.address)
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        .listRowBackground(Color.black)
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
