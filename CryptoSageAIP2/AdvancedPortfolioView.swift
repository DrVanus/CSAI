//
//  Transaction.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI
import Charts

// Dummy transaction model (you may already have one; if so, remove this duplicate)
struct Transaction: Identifiable {
    let id = UUID()
    let date: Date
    let type: String  // e.g. "Buy" or "Sell"
    let amount: Double
    let symbol: String
}

// A data point for the portfolio chart.
struct PortfolioDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

struct AdvancedPortfolioView: View {
    @State private var totalValue: Double = 12345.67
    @State private var change24h: Double = 0.0283
    @State private var dataPoints: [PortfolioDataPoint] = [
        PortfolioDataPoint(date: Date().addingTimeInterval(-86400 * 5), value: 10000),
        PortfolioDataPoint(date: Date().addingTimeInterval(-86400 * 4), value: 10500),
        PortfolioDataPoint(date: Date().addingTimeInterval(-86400 * 3), value: 10200),
        PortfolioDataPoint(date: Date().addingTimeInterval(-86400 * 2), value: 10800),
        PortfolioDataPoint(date: Date().addingTimeInterval(-86400 * 1), value: 11000),
        PortfolioDataPoint(date: Date(), value: 12345.67)
    ]
    @State private var transactions: [Transaction] = [
        Transaction(date: Date().addingTimeInterval(-3600), type: "Buy", amount: 0.5, symbol: "BTC"),
        Transaction(date: Date().addingTimeInterval(-7200), type: "Sell", amount: 1.0, symbol: "ETH")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Portfolio Summary
                    VStack(spacing: 8) {
                        Text(totalValue, format: .currency(code: "USD"))
                            .font(.largeTitle)
                            .bold()
                        Text("24h Change: \(change24h * 100, specifier: "%.2f")%")
                            .font(.subheadline)
                            .foregroundColor(change24h >= 0 ? .green : .red)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    // Portfolio Chart (using Swift Charts, available in iOS 16+)
                    if #available(iOS 16.0, *) {
                        Chart(dataPoints) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Value", point.value)
                            )
                        }
                        .frame(height: 200)
                        .padding()
                    } else {
                        Text("Chart not available on this iOS version.")
                    }
                    
                    // Transaction History
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent Transactions")
                            .font(.headline)
                        ForEach(transactions) { tx in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(tx.type) \(tx.amount, specifier: "%.2f") \(tx.symbol)")
                                        .bold()
                                    Text(tx.date, style: .time)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Portfolio")
        }
    }
}

struct AdvancedPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedPortfolioView()
    }
}