//
//  Transaction.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

//
//  TransactionDetailView.swift
//  CryptoSageAIP2
//
//  Created by ChatGPT on 2/27/25.
//

//
//  TransactionDetailView.swift
//  CryptoSageAIP2
//
//  Created by ChatGPT on 2/27/25.
//

import SwiftUI

/// Example Transaction model for this detail view.
/// Adjust or expand as needed for your actual data.
struct Transaction: Identifiable {
    let id = UUID()
    let type: String       // e.g. "Buy" or "Sell"
    let symbol: String     // e.g. "BTC"
    let amount: Double     // e.g. 1.23
    let price: Double      // e.g. 28000.0
    let date: Date         // e.g. Date() for transaction date
    let notes: String      // optional notes, can be empty
}

/// A simple detail screen for one transaction.
struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transaction Details")
                .font(.title2)
                .bold()

            // Display each field. Adjust or remove as needed.
            HStack {
                Text("Type:")
                Text(transaction.type)
                    .bold()
            }
            HStack {
                Text("Symbol:")
                Text(transaction.symbol)
                    .bold()
            }
            HStack {
                Text("Amount:")
                Text("\(transaction.amount, specifier: "%.4f")")
                    .bold()
            }
            HStack {
                Text("Price:")
                Text("$\(transaction.price, specifier: "%.2f")")
                    .bold()
            }
            HStack {
                Text("Date:")
                Text("\(transaction.date, style: .date)")
                    .bold()
            }
            if !transaction.notes.isEmpty {
                HStack {
                    Text("Notes:")
                    Text(transaction.notes)
                        .bold()
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(
            transaction: Transaction(
                type: "Buy",
                symbol: "BTC",
                amount: 1.2345,
                price: 28000.0,
                date: Date(),
                notes: "Test transaction"
            )
        )
    }
}
