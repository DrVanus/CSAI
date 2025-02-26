//
//  HomeView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var marketVM: MarketViewModel
    let tradeVM: TradeViewModel?
    let onOpenSettings: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Tab Placeholder")
                    .foregroundColor(.white)
                    .padding()
                // Insert your advanced UI here...
                
                Button("Open Settings") {
                    onOpenSettings()
                }
            }
            .background(Color.black)
            .navigationBarTitle("Home", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(), marketVM: MarketViewModel(), tradeVM: TradeViewModel()) {
            print("Settings opened")
        }
    }
}
