//
//  LibraryView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Subtle background color
                Color(uiColor: .systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                if library.savedStories.isEmpty {
                    Text("No saved stories yet")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach($library.savedStories) { $item in
                            NavigationLink(destination: LibraryDetailView(item: $item)) {
                                LibraryRow(item: item)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    if let index = library.savedStories.firstIndex(where: { $0.id == item.id }) {
                                        library.savedStories.remove(at: index)
                                    }
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden) // iOS 16+
                }
            }
            .navigationTitle("Library")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LibraryRow: View {
    let item: LibraryItem
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "book.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                ProgressView(value: item.readingProgress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .brandPrimary))
                    .frame(width: 120)
            }
        }
        .padding(.vertical, 4)
    }
}
