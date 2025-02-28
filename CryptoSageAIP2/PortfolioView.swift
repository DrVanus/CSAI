//
//  PortfolioView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct PortfolioCoin: Identifiable {
    let id = UUID()
    let symbol: String
    let amount: Double
    let totalValue: Double
    let dailyChange: Double
}

struct PortfolioView: View {
    @State private var totalPortfolioValue: Double = 99770.0
    @State private var distributionPercentage: Double = 0.7 // Example
    @State private var portfolioCoins: [PortfolioCoin] = [
        PortfolioCoin(symbol: "BTC", amount: 1.0, totalValue: 97500.0, dailyChange: 0.0),
        PortfolioCoin(symbol: "SOL", amount: 70.0, totalValue: 170.0, dailyChange: 0.0),
        PortfolioCoin(symbol: "ETH", amount: 90.0, totalValue: 2100.0, dailyChange: 0.0)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Distribution Pie Chart Placeholder
                    ZStack {
                        Circle()
                            .trim(from: 0, to: distributionPercentage)
                            .stroke(Color.blue, lineWidth: 30)
                            .rotationEffect(.degrees(-90))
                            .frame(width: 150, height: 150)
                        Text("Distribution")
                            .font(.caption)
                    }
                    
                    // Portfolio Value
                    Text("Total Value: $\(totalPortfolioValue, specifier: "%.2f")")
                        .font(.title2)
                        .bold()
                    
                    // Coin list
                    ForEach(portfolioCoins) { coin in
                        VStack(alignment: .leading) {
                            Text("\(coin.symbol) Amount: \(coin.amount, specifier: "%.2f")")
                                .bold()
                            Text("Value: $\(coin.totalValue, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Daily Change: \(coin.dailyChange >= 0 ? "+" : "")\(coin.dailyChange, specifier: "%.2f")%")
                                .font(.caption)
                                .foregroundColor(coin.dailyChange >= 0 ? .green : .red)
                        }
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                    
                    // Add Transaction button
                    Button(action: {
                        // Show a transaction form or something
                    }) {
                        Text("Add Transaction")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    // Navigation to Transaction History
                    NavigationLink(destination: TransactionHistoryView()) {
                        Text("View Transaction History")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Portfolio")
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
