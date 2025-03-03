//
//  MarketplaceDetailView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct MarketplaceDetailView: View {
    let item: MarketplaceItem
    
    @State private var showPurchaseAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Book / Pack Name
                Text(item.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                // Description
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Price
                Text("Price: \(item.price)")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                
                // "Buy" Button
                Button(action: {
                    showPurchaseAlert = true
                }) {
                    Text("Buy Now")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary)
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.top, 40)
        }
        .navigationBarTitle(item.name, displayMode: .inline)
        .alert(isPresented: $showPurchaseAlert) {
            Alert(
                title: Text("Purchase Complete"),
                message: Text("You have purchased \(item.name)."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct MarketplaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceDetailView(item: MarketplaceItem(
            name: "Treasure Island Pack",
            description: "Pirate expansions",
            price: "$3.99",
            genre: "Adventure"
        ))
    }
}
