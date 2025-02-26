//
//  PortfolioView.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct PortfolioView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Portfolio Tab Placeholder")
                    .foregroundColor(.white)
                    .padding()
                // Insert your portfolio UI here...
            }
            .background(Color.black)
            .navigationBarTitle("Portfolio", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
