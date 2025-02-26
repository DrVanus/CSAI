//
//  TradeView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct TradeView: View {
    @ObservedObject var tradeVM: TradeViewModel
    
    @State private var showAdvancedTrading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        Text("Trade Tab")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        // Example placeholders for order forms, TAs, etc.
                        Text("Selected Symbol: \(tradeVM.selectedSymbol)")
                            .foregroundColor(.white)
                        TextField("Limit Price", text: $tradeVM.limitPrice)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
                        // Fraction buttons
                        HStack {
                            ForEach([0.25, 0.5, 0.75, 1.0], id: \.self) { fraction in
                                Button("\(Int(fraction*100))%") {
                                    tradeVM.applyFraction(fraction)
                                }
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                            }
                        }
                        
                        Button("Submit Order") {
                            tradeVM.submitOrder()
                        }
                        .foregroundColor(.white)
                        .padding(6)
                        .background(tradeVM.side == "Buy" ? Color.green : Color.red)
                        .cornerRadius(8)
                        
                        if !tradeVM.aiSuggestion.isEmpty {
                            Text(tradeVM.aiSuggestion)
                                .foregroundColor(.yellow)
                                .font(.subheadline)
                        }
                        
                        Toggle("Show Advanced Trading", isOn: $showAdvancedTrading)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        if showAdvancedTrading {
                            Text("Placeholder for advanced order book, depth chart, etc.")
                                .foregroundColor(.gray)
                                .padding()
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
