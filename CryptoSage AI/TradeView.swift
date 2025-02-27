//
//  TradeView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct TradeView: View {
    @ObservedObject var tradeVM: TradeViewModel
    @State private var showAdvancedTrading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        Text("Trade \(tradeVM.selectedSymbol)")
                            .font(.title2)
                            .foregroundColor(.white)
                        HStack {
                            Picker("Side", selection: $tradeVM.side) {
                                Text("Buy").tag("Buy")
                                Text("Sell").tag("Sell")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        HStack {
                            Picker("Order Type", selection: $tradeVM.orderType) {
                                Text("Market").tag("Market")
                                Text("Limit").tag("Limit")
                                Text("Stop-Limit").tag("Stop-Limit")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        if tradeVM.orderType == "Limit" || tradeVM.orderType == "Stop-Limit" {
                            TextField("Limit Price", text: $tradeVM.limitPrice)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                        }
                        if tradeVM.orderType == "Stop-Limit" {
                            TextField("Stop Price", text: $tradeVM.stopPrice)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                        }
                        if tradeVM.orderType == "Stop-Limit" {
                            TextField("Trailing Stop", text: $tradeVM.trailingStop)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                        }
                        HStack {
                            Text("Quantity: \(tradeVM.quantity)")
                                .foregroundColor(.white)
                            Button("Set 50%") {
                                tradeVM.applyFraction(0.5)
                            }
                            .padding(6)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                        }
                        Button("Submit Order") {
                            tradeVM.submitOrder()
                        }
                        .padding()
                        .background(tradeVM.side == "Buy" ? Color.green : Color.red)
                        .cornerRadius(8)
                        if !tradeVM.aiSuggestion.isEmpty {
                            Text(tradeVM.aiSuggestion)
                                .foregroundColor(.yellow)
                        }
                        Toggle("Show Advanced Trading", isOn: $showAdvancedTrading)
                            .foregroundColor(.white)
                        if showAdvancedTrading {
                            Text("Advanced trading features coming soon...")
                                .foregroundColor(.gray)
                        }
                        Spacer().frame(height: 80)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Trade", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView(tradeVM: TradeViewModel())
    }
}
