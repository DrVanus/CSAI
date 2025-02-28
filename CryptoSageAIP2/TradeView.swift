//
//  TradeView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct TradeView: View {
    @State private var selectedPair: String = "BTC-USD"
    @State private var tradeType: String = "Buy"
    @State private var orderQuantity: String = ""
    @State private var pairs: [String] = ["BTC-USD", "ETH-USD", "SOL-USD"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Chart placeholder
                ZStack {
                    Rectangle()
                        .fill(Color.green.opacity(0.2))
                        .cornerRadius(10)
                    Text("Trading Chart Placeholder")
                        .foregroundColor(.green)
                }
                .frame(height: 200)
                .padding(.horizontal)
                
                // Pair Picker
                Picker("Select Pair", selection: $selectedPair) {
                    ForEach(pairs, id: \.self) { pair in
                        Text(pair).tag(pair)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Trade Type
                Picker("Trade Type", selection: $tradeType) {
                    Text("Buy").tag("Buy")
                    Text("Sell").tag("Sell")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Order Quantity
                TextField("Enter Quantity", text: $orderQuantity)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Place Order Button
                Button(action: {
                    // Simulate placing an order
                    print("\(tradeType) \(orderQuantity) of \(selectedPair)")
                }) {
                    Text("\(tradeType) Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(tradeType == "Buy" ? Color.green : Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Trade")
        }
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView()
    }
}
