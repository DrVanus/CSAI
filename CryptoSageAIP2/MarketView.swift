//
//  MarketAsset.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct MarketView: View {
    @StateObject private var viewModel = MarketViewModel()
    @State private var searchText: String = ""
    
    var filteredAssets: [MarketAsset] {
        if searchText.isEmpty {
            return viewModel.assets
        } else {
            return viewModel.assets.filter { asset in
                asset.symbol.localizedCaseInsensitiveContains(searchText) ||
                asset.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search coins...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
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
                                    .font(.subheadline)
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
            .navigationTitle("Market")
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
