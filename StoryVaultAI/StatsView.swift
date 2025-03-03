//
//  StatsView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Your Stats")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    let total = library.savedStories.count
                    let completed = library.savedStories.filter { $0.readingProgress == 1.0 }.count
                    
                    statCard(title: "Saved Stories", value: "\(total)")
                    statCard(title: "Completed Stories", value: "\(completed)")
                    
                    Spacer().frame(height: 40)
                }
            }
        }
        .navigationBarTitle("Stats", displayMode: .inline)
    }
    
    private func statCard(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.purple.opacity(0.6))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        let library = LibraryModel()
        library.savedStories = [
            LibraryItem(title: "Dracula", readingProgress: 1.0),
            LibraryItem(title: "Treasure Island", readingProgress: 0.5),
            LibraryItem(title: "Frankenstein", readingProgress: 1.0)
        ]
        return StatsView().environmentObject(library)
    }
}
