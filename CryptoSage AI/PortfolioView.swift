//
//  PortfolioView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct PortfolioView: View {
    @State private var holdings: [Holding] = []
    @State private var showAddTxSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        let totalValue = holdings.reduce(0) { $0 + $1.totalValue }
                        Text("Total Portfolio Value: $\(totalValue, specifier: "%.2f")")
                            .foregroundColor(.gray)
                            .font(.title2)
                        CardView {
                            Text("Portfolio Distribution Chart Placeholder")
                                .foregroundColor(.white)
                        }
                        ForEach(holdings) { holding in
                            CardView {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(holding.symbol)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Amount: \(holding.amount, specifier: "%.4f")")
                                        .foregroundColor(.white)
                                    Text("Value: $\(holding.totalValue, specifier: "%.2f")")
                                        .foregroundColor(.white)
                                    let pct = holding.dailyChangePercent
                                    Text("Daily Change: \(pct >= 0 ? "+" : "")\(pct, specifier: "%.2f")%")
                                        .foregroundColor(pct >= 0 ? .green : .red)
                                        .font(.footnote)
                                }
                            }
                        }
                        Button("Add Transaction") {
                            showAddTxSheet = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            }
            .navigationBarTitle("Portfolio", displayMode: .inline)
            .sheet(isPresented: $showAddTxSheet) {
                AddTransactionView { newHolding in
                    holdings.append(newHolding)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var symbol = "BTC"
    @State private var amount = ""
    @State private var cost = ""
    
    let onAdd: (Holding) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Info")) {
                    TextField("Symbol", text: $symbol)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    TextField("Cost (USD)", text: $cost)
                        .keyboardType(.decimalPad)
                }
                Button("Add") {
                    let amt = Double(amount) ?? 0
                    let cst = Double(cost) ?? 0
                    let holding = Holding(symbol: symbol.uppercased(), amount: amt, totalValue: cst, dailyChangePercent: 0)
                    onAdd(holding)
                    dismiss()
                }
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(8)
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
