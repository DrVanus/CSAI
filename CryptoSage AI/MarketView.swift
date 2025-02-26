//
//  MarketView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct MarketView: View {
    @ObservedObject var marketVM: MarketViewModel
    @ObservedObject var homeVM: HomeViewModel
    let tradeVM: TradeViewModel?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Market Tab Placeholder")
                    .foregroundColor(.white)
                    .padding()
                // Insert your advanced UI here...
            }
            .background(Color.black)
            .navigationBarTitle("Market", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView(marketVM: MarketViewModel(), homeVM: HomeViewModel(), tradeVM: TradeViewModel())
    }
}
