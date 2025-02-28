//
//  AnalyticsData.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI
import Combine

struct AnalyticsData {
    let date: Date
    let portfolioValue: Double
}

class AnalyticsViewModel: ObservableObject {
    @Published var dataPoints: [AnalyticsData] = [
        AnalyticsData(date: Date().addingTimeInterval(-86400*5), portfolioValue: 10000),
        AnalyticsData(date: Date().addingTimeInterval(-86400*4), portfolioValue: 10500),
        AnalyticsData(date: Date().addingTimeInterval(-86400*3), portfolioValue: 10200),
        AnalyticsData(date: Date().addingTimeInterval(-86400*2), portfolioValue: 10800),
        AnalyticsData(date: Date().addingTimeInterval(-86400*1), portfolioValue: 11000),
        AnalyticsData(date: Date(), portfolioValue: 11500)
    ]
    
    func refreshAnalytics() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let randomChange = Double.random(in: -500...500)
            let lastValue = self.dataPoints.last?.portfolioValue ?? 10000
            let newValue = max(0, lastValue + randomChange)
            
            self.dataPoints.append(AnalyticsData(date: Date(), portfolioValue: newValue))
        }
    }
}

struct AnalyticsView: View {
    @ObservedObject var viewModel = AnalyticsViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Analytics")
                .font(.headline)
                .padding(.top, 8)
            
            // A horizontal scroll view showing bar-like charts for each data point
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 16) {
                    ForEach(viewModel.dataPoints, id: \.date) { dp in
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 10, height: barHeight(for: dp.portfolioValue))
                            
                            // Updated to .date instead of .shortDate
                            Text("\(dp.date, style: .date)")
                                .font(.caption2)
                                .rotationEffect(.degrees(-45))
                                .offset(y: 10)
                        }
                    }
                }
                .padding()
            }
            
            Button("Refresh Analytics") {
                viewModel.refreshAnalytics()
            }
            .font(.subheadline)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }
    
    private func barHeight(for value: Double) -> CGFloat {
        // Scale the bar height for demonstration
        return CGFloat(value / 50)
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
