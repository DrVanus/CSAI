//
//  PortfolioView.swift
//  CryptoSage AI2
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
                        
                        CardView(cornerRadius: 8, paddingAmount: 4) {
                            ZStack {
                                ringChart(for: data)
                                    .aspectRatio(1.0, contentMode: .fit)
                                Text("Distribution")
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
                        
                        CardView(cornerRadius: 6, paddingAmount: 6) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Linked Accounts")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Link wallets/exchanges directly from your Portfolio (placeholder).")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                                Button {
                                    // placeholder
                                } label: {
                                    Text("Link a Wallet/Exchange")
                                        .font(.subheadline)
                                        .padding(6)
                                        .background(Color.blue.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        
                        CardView(cornerRadius: 6, paddingAmount: 6) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Advanced Portfolio Stats (Placeholder)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Divider().background(Color.gray)
                                Text("In the future, you could show performance or historical data.")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                        }
                        
                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
            }
            .navigationBarTitle("Portfolio", displayMode: .inline)
            .onAppear { loadHoldings() }
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
    
    func ringChart(for data: [Holding]) -> some View {
        let totalValue = data.reduce(0) { $0 + $1.totalValue }
        let segments = data.enumerated().map { (index, h) -> Segment in
            let fraction = totalValue == 0 ? 0 : h.totalValue / totalValue
            let color = chartColors[index % chartColors.count]
            return Segment(color: color, fraction: fraction, label: h.symbol)
        }
        return ZStack {
            ForEach(0..<segments.count, id: \.self) { i in
                let startAngle = angleUpToSegment(segments, i)
                let endAngle   = angleUpToSegment(segments, i+1)
                RingSlice(startAngle: startAngle, endAngle: endAngle, color: segments[i].color)
            }
        }
    }
    
    func angleUpToSegment(_ segments: [Segment], _ index: Int) -> Angle {
        let fraction = segments.prefix(index).map(\.fraction).reduce(0, +)
        return .degrees(fraction * 360)
    }
    
    let chartColors: [Color] = [.blue, .green, .purple, .orange, .pink, .red, .yellow]
    
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
