//
//  PortfolioSummaryView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI

struct PortfolioSummaryView: View {
    var totalPortfolioValue: Double
    var portfolioChange24h: Double
    
    var body: some View {
        VStack(spacing: 8) {
            // Display the portfolio value (e.g., "$12,345.67")
            Text(totalPortfolioValue, format: .currency(code: "USD"))
                .font(.system(size: 36, weight: .bold))
                .multilineTextAlignment(.center)
            
            // Display the 24-hour change
            Text(formattedChangeText)
                .font(.subheadline)
                .foregroundColor(portfolioChange24h >= 0 ? .green : .red)
        }
        // Additional styling (like background cards or shadows) can be added here if desired.
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
    
    private var formattedChangeText: String {
        let percent = portfolioChange24h * 100
        let sign = portfolioChange24h >= 0 ? "+" : ""
        return "24h Change: \(sign)\(String(format: "%.2f", percent))%"
    }
}

struct PortfolioSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSummaryView(totalPortfolioValue: 12345.67, portfolioChange24h: 0.0283)
    }
}