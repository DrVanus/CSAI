





//
//  NotificationItem.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI

/// A model representing a single notification.
struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let date: Date
}

struct NotificationsView: View {
    // Sample notifications data
    @State private var notifications: [NotificationItem] = [
        NotificationItem(title: "Market Update", message: "Bitcoin rose by 3% today.", date: Date().addingTimeInterval(-3600)),
        NotificationItem(title: "Portfolio Alert", message: "Your portfolio has increased by 2.5% in the last 24h.", date: Date().addingTimeInterval(-7200)),
        NotificationItem(title: "News Flash", message: "Ethereum upgrade is now live!", date: Date().addingTimeInterval(-10800))
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Optional header
            Text("Notifications")
                .font(.headline)
                .padding(.top, 8)
            
            // List of notifications
            List(notifications) { notification in
                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.title)
                        .font(.subheadline)
                        .bold()
                    Text(notification.message)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(notification.date, style: .time)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .navigationTitle("") // No unwanted title
        .navigationBarHidden(true)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
