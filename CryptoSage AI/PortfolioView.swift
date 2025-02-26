//
//  PortfolioView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct PortfolioView: View {
    @State private var holdings: [Holding] = []
    @State private var showAddTxSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 12) {
                        let data = holdings.isEmpty ? sampleHoldings : holdings
                        let totalValue = data.reduce(0) { $0 + $1.totalValue }
                        
                        Text("Total Value: $\(totalValue, specifier: "%.2f")")
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                        
                        // Example ring chart placeholder
                        CardView(cornerRadius: 8, paddingAmount: 4) {
                            ZStack {
                                Text("Distribution Placeholder")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .frame(height: 260)
                        }
                        
                        VStack(spacing: 8) {
                            ForEach(data) { h in
                                CardView(cornerRadius: 6, paddingAmount: 6) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(h.symbol)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("Amount: \(h.amount, specifier: "%.4f")")
                                            .foregroundColor(.white.opacity(0.8))
                                        Text("Value: $\(h.totalValue, specifier: "%.2f")")
                                            .foregroundColor(.white.opacity(0.8))
                                        let pct = h.dailyChangePercent
                                        Text("Daily Change: \(pct >= 0 ? "+" : "")\(pct, specifier: "%.2f")%")
                                            .foregroundColor(pct >= 0 ? .green : .red)
                                            .font(.footnote)
                                    }
                                }
                            }
                        }
                        
                        Button {
                            showAddTxSheet = true
                        } label: {
                            Text("Add Transaction")
                                .font(.headline)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
            }
            .navigationBarTitle("Portfolio", displayMode: .inline)
            .onAppear {
                loadHoldings()
            }
            .sheet(isPresented: $showAddTxSheet) {
                AddTransactionView { newHolding in
                    holdings.append(newHolding)
                    saveHoldings()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var sampleHoldings: [Holding] {
        [
            Holding(symbol: "BTC", amount: 0.5,  totalValue: 15000, dailyChangePercent: 1.2),
            Holding(symbol: "ETH", amount: 2.0,  totalValue: 4200,  dailyChangePercent: -0.5),
            Holding(symbol: "DOGE", amount: 1000, totalValue: 90,   dailyChangePercent: 3.1)
        ]
    }
    
    func saveHoldings() {
        do {
            let data = try JSONEncoder().encode(holdings)
            UserDefaults.standard.set(data, forKey: "holdingsData")
        } catch {
            print("Error encoding holdings: \(error)")
        }
    }
    
    func loadHoldings() {
        guard let data = UserDefaults.standard.data(forKey: "holdingsData") else { return }
        do {
            let decoded = try JSONDecoder().decode([Holding].self, from: data)
            self.holdings = decoded
        } catch {
            print("Error decoding holdings: \(error)")
        }
    }
}

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var symbol = "BTC"
    @State private var amount = ""
    @State private var cost   = ""
    
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
