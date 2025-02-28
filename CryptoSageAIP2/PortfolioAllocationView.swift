//
//  AllocationItem.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI

struct AllocationItem: Identifiable {
    let id = UUID()
    let asset: String
    let percentage: Double
}

struct PortfolioAllocationView: View {
    // Dummy allocation data; replace with your actual data from your old code.
    var allocationItems: [AllocationItem] = [
        AllocationItem(asset: "BTC", percentage: 40),
        AllocationItem(asset: "ETH", percentage: 30),
        AllocationItem(asset: "LTC", percentage: 20),
        AllocationItem(asset: "XRP", percentage: 10)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Portfolio Allocation")
                .font(.headline)
            
            // Simulated pie chart placeholder.
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 40)
                    .rotationEffect(.degrees(-90))
                // In a real chart, you would draw segments for each asset.
                Text("Pie Chart")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .frame(width: 200, height: 200)
            
            // List the allocation items.
            ForEach(allocationItems) { item in
                HStack {
                    Text(item.asset)
                        .font(.subheadline)
                    Spacer()
                    Text("\(item.percentage, specifier: "%.0f")%")
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct PortfolioAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioAllocationView()
    }
}