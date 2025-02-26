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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Trade Tab Placeholder")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.black)
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
