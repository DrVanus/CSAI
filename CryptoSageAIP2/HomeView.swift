//
//  HomeView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct HomeView: View {
    // Example state variables
    @State private var portfolioValue: Double = 12345.67
    @State private var change24h: Double = 0.0283
    @State private var watchlistItems: [String] = ["BTC", "ETH", "LTC", "XRP"]
    @State private var newsItems: [String] = [
        "Bitcoin hits new all-time high!",
        "Ethereum upgrade successful!",
        "Crypto market volatile as investors weigh risks."
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Portfolio Summary
                    VStack(spacing: 8) {
                        Text(portfolioValue, format: .currency(code: "USD"))
                            .font(.system(size: 36, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        Text("24h Change: \(change24h >= 0 ? "+" : "")\(change24h * 100, specifier: "%.2f")%")
                            .font(.subheadline)
                            .foregroundColor(change24h >= 0 ? .green : .red)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    
                    // Watchlist
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Watchlist")
                            .font(.headline)
                        
                        HStack {
                            ForEach(watchlistItems, id: \.self) { item in
                                Text(item)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    
                    // AI Chat Preview
                    VStack(alignment: .leading, spacing: 10) {
                        Text("AI Chat (Preview)")
                            .font(.headline)
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                                .overlay(Text("AI").foregroundColor(.white))
                            VStack(alignment: .leading) {
                                Text("CryptoSage AI")
                                    .font(.subheadline)
                                    .bold()
                                Text("Your portfolio looks strong today!")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    // News Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Crypto News")
                            .font(.headline)
                        ForEach(newsItems, id: \.self) { news in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(news)
                                    .font(.subheadline)
                                    .bold()
                                Text("Source: Example Crypto News")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(8)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
