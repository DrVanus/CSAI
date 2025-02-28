//
//  WatchlistView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct WatchlistView: View {
    // Sample data: Replace these with your actual migrated watchlist data.
    var watchlistItems: [String] = ["BTC", "ETH", "LTC", "XRP"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Optional header—if you want to remove it, simply delete this Text view.
            Text("Watchlist")
                .font(.headline)
            
            // Display each watchlist item in a row.
            ForEach(watchlistItems, id: \.self) { item in
                HStack {
                    Text(item)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
