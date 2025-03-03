//
//  FeaturedStoryViews.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

// MARK: - Data Model for Featured Stories
struct FeaturedStory: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
}

// MARK: - Featured Story Detail View
struct FeaturedStoryDetailView: View {
    @EnvironmentObject var library: LibraryModel
    let story: FeaturedStory
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .indigo]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(systemName: story.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .background(Color.brandPrimary.opacity(0.2))
                    .cornerRadius(12)
                
                Text(story.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Text(story.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Add to Library") {
                    library.addStory(title: story.title)
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary)
            }
            .padding()
        }
        .navigationBarTitle(story.title, displayMode: .inline)
    }
}
