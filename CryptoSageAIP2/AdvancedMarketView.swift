//
//  AdvancedMarketView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI

struct AdvancedMarketView: View {
    @StateObject private var viewModel = MarketViewModel() // Defined in your model file
    @State private var searchText: String = ""
    
    // Filtered assets based on search text.
    var filteredAssets: [MarketAsset] {
        if searchText.isEmpty {
            return viewModel.assets
        } else {
            return viewModel.assets.filter { asset in
                asset.name.localizedCaseInsensitiveContains(searchText) ||
                asset.symbol.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search assets...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // List of coins
                List(filteredAssets) { asset in
                    NavigationLink(destination: CoinDetailView(
                        coinSymbol: asset.symbol,
                        coinName: asset.name,
                        currentPrice: asset.price,
                        change24h: asset.change24h
                    )) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(asset.symbol) - \(asset.name)")
                                    .bold()
                                Text(String(format: "$%.2f", asset.price))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(String(format: "%.2f%%", asset.change24h))
                                .font(.caption)
                                .foregroundColor(asset.change24h >= 0 ? .green : .red)
                        }
                        .padding(8)
                    }
                }
            }
            .navigationTitle("Markets")
        }
    }
}

struct AdvancedMarketView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedMarketView()
    }
}