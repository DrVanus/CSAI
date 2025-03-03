//
//  LibraryDetailView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct LibraryDetailView: View {
    @Binding var item: LibraryItem
    
    var body: some View {
        Form {
            Section(header: Text("STORY INFO")) {
                Text("Title: \(item.title)")
                
                // Progress Ring
                VStack {
                    ZStack {
                        // Background ring
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                            .frame(width: 80, height: 80)
                        
                        // Foreground ring trimmed to readingProgress
                        Circle()
                            .trim(from: 0, to: CGFloat(item.readingProgress))
                            .stroke(
                                Color.brandPrimary,
                                style: StrokeStyle(lineWidth: 10, lineCap: .round)
                            )
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(-90))
                        
                        // Percentage text
                        Text("\(Int(item.readingProgress * 100))%")
                            .font(.headline)
                            .foregroundColor(.brandPrimary)
                    }
                    .padding(.vertical, 8)
                }
                
                // "Mark as Completed" with brand color
                Button("Mark as Completed") {
                    item.readingProgress = 1.0
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary) // <-- Use your brand color instead of green
            }
        }
        .navigationTitle("Library Detail")
    }
}

struct LibraryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Example preview
        LibraryDetailView(item: .constant(LibraryItem(
            title: "Treasure Island",
            readingProgress: 0.35
        )))
    }
}
