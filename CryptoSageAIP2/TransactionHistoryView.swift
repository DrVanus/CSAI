//
//  Transaction.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

// Reuse the Transaction model from earlier or define a new one if needed

struct TransactionHistoryView: View {
    @State private var transactions: [Transaction] = [
        Transaction(date: Date().addingTimeInterval(-3600), type: "Buy", amount: 0.5, symbol: "BTC"),
        Transaction(date: Date().addingTimeInterval(-7200), type: "Sell", amount: 2.0, symbol: "ETH"),
        // ...
    ]
    
    var body: some View {
        List(transactions) { tx in
            VStack(alignment: .leading) {
                Text("\(tx.type) \(tx.amount, specifier: "%.2f") \(tx.symbol)")
                    .bold()
                Text("Date: \(tx.date, style: .date) \(tx.date, style: .time)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(8)
        }
        .navigationTitle("Transaction History")
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView()
    }
}
