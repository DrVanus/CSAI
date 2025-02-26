//
//  AITabView 2.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct AITabView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("AI Chat Placeholder")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.black)
            .navigationBarTitle("AI Chat", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AITabView_Previews: PreviewProvider {
    static var previews: some View {
        AITabView()
    }
}
