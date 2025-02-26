//
//  MarketView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct MarketView: View {
    // Insert any @State or @ObservedObject properties you need for the Market tab
    @ObservedObject var marketVM: MarketViewModel
    @ObservedObject var homeVM: HomeViewModel
    @ObservedObject var tradeVM: TradeViewModel

    @State private var searchText: String = ""
    @State private var sortOption: MarketSortOption = .name
    @State private var includeSolana: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 0) {
                        // Example: a toggle and search field; replace with your full Market UI
                        Toggle("Include Solana (DexScreener)", isOn: $includeSolana)
                            .padding()
                            .foregroundColor(.white)
                        
                        HStack {
                            TextField("Search coins...", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading)
                                .padding(.vertical, 6)
                            
                            Spacer()
                            
                            Menu("Sort By") {
                                Button("Name") { sortOption = .name }
                                Button("Price") { sortOption = .price }
                                Button("24h %") { sortOption = .change }
                            }
                            .padding(.trailing, 8)
                            .foregroundColor(.white)
                        }
                        
                        // Insert your list/table/chart code here (the complete Market section)
                        // For example, ForEach over marketVM.marketCoins, etc.
                    }
                }
                .refreshable {
                    marketVM.fetchMarketCoins()
                }
            }
            .navigationBarTitle("Market", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// Example enum used for sorting; adjust to your original code:
enum MarketSortOption {
    case name, price, change
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview, you can use sample view models.
        MarketView(marketVM: MarketViewModel(), homeVM: HomeViewModel(), tradeVM: TradeViewModel())
    }
}