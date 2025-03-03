//
//  HomeView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var library: LibraryModel

    @State private var rowWidthFantasy: CGFloat = 0
    @State private var rowWidthAdventure: CGFloat = 0
    @State private var rowWidthHorror: CGFloat = 0
    @State private var rowWidthRomance: CGFloat = 0

    let fantasyBooks: [FeaturedStory] = [
        FeaturedStory(title: "Alice’s Adventures in Wonderland", imageName: "book.fill", description: "Whimsical classic by Lewis Carroll"),
        FeaturedStory(title: "The Wonderful Wizard of Oz", imageName: "book.fill", description: "Dorothy’s journey in Oz"),
        FeaturedStory(title: "Peter Pan", imageName: "book.fill", description: "Neverland adventures"),
        FeaturedStory(title: "Grimm’s Fairy Tales", imageName: "book.fill", description: "Classic fairy tales")
    ]
    
    let adventureBooks: [FeaturedStory] = [
        FeaturedStory(title: "Treasure Island", imageName: "book.fill", description: "Pirate adventure"),
        FeaturedStory(title: "The Count of Monte Cristo", imageName: "book.fill", description: "Betrayal & revenge"),
        FeaturedStory(title: "The Odyssey", imageName: "book.fill", description: "Epic Greek journey"),
        FeaturedStory(title: "Robinson Crusoe", imageName: "book.fill", description: "Desert island survival")
    ]
    
    let horrorBooks: [FeaturedStory] = [
        FeaturedStory(title: "Dracula", imageName: "book.fill", description: "Seminal vampire horror"),
        FeaturedStory(title: "Frankenstein", imageName: "book.fill", description: "Gothic sci‑fi by Mary Shelley"),
        FeaturedStory(title: "Carmilla", imageName: "book.fill", description: "Atmospheric vampire story"),
        FeaturedStory(title: "Jekyll and Hyde", imageName: "book.fill", description: "Dark dual personality tale")
    ]
    
    let romanceBooks: [FeaturedStory] = [
        FeaturedStory(title: "Pride and Prejudice", imageName: "book.fill", description: "Jane Austen’s witty romance"),
        FeaturedStory(title: "Jane Eyre", imageName: "book.fill", description: "Strong-willed governess story"),
        FeaturedStory(title: "Wuthering Heights", imageName: "book.fill", description: "Passionate love on the moors"),
        FeaturedStory(title: "Little Women", imageName: "book.fill", description: "Coming-of-age of four sisters")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                DynamicDarkGradientBackground()
                // Optional top wave shape
                VStack {
                    TopWaveShape()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 160)
                        .offset(y: -80)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                
                ScrollView {
                    VStack(spacing: 24) {
                        Spacer().frame(height: 20)
                        
                        VStack(spacing: 8) {
                            Text("StoryVault AI")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            Text("Unlock Your Imagination")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        NavigationLink(destination: WriteYourOwnStoryView()) {
                            Text("Write Your Own Story")
                        }
                        .buttonStyle(LuxuryButtonStyle())
                        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
                        
                        if let _ = library.lastSegmentID,
                           let lastItem = library.savedStories.last {
                            Text("Recently Read")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            HStack(spacing: 12) {
                                Text(lastItem.title)
                                    .foregroundColor(.white)
                                Button("Continue") {
                                    // Navigation action
                                }
                                .font(.caption).bold()
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(4)
                                .background(Color.brandPrimary)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        
                        NavigationLink(destination: BeowulfAdventureView()) {
                            Text("AI Adventure (Beta)")
                                .font(.body)
                                .foregroundColor(.white)
                                .underline()
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                Text("Fantasy")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                FeaturedStoriesRowView(stories: fantasyBooks, rowWidth: $rowWidthFantasy)
                                    .frame(height: 120)
                                    .environmentObject(library)
                            }
                            
                            Group {
                                Text("Adventure")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                FeaturedStoriesRowView(stories: adventureBooks, rowWidth: $rowWidthAdventure)
                                    .frame(height: 120)
                                    .environmentObject(library)
                            }
                            
                            Group {
                                Text("Horror / Gothic")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                FeaturedStoriesRowView(stories: horrorBooks, rowWidth: $rowWidthHorror)
                                    .frame(height: 120)
                                    .environmentObject(library)
                            }
                            
                            Group {
                                Text("Romance")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                FeaturedStoriesRowView(stories: romanceBooks, rowWidth: $rowWidthRomance)
                                    .frame(height: 120)
                                    .environmentObject(library)
                            }
                        }
                        
                        Spacer().frame(height: 60)
                    }
                    .padding(.horizontal, 30)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LibraryModel())
    }
}
