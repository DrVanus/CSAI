//
//  LibraryModel.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

/// Each saved story in the library
struct LibraryItem: Identifiable {
    let id = UUID()
    var title: String
    var readingProgress: Double // 0...1
}

class LibraryModel: ObservableObject {
    /// We store LibraryItem (not just String),
    /// so we can have reading progress and a 'title' property.
    @Published var savedStories: [LibraryItem] = []
    
    /// If you want to remember the last story segment ID the user visited
    @Published var lastSegmentID: String? = nil
    
    /// Add a new story by title if it's not already in the library
    func addStory(title: String) {
        // Check if we already have an item with this title
        if !savedStories.map({ $0.title }).contains(title) {
            let newItem = LibraryItem(title: title, readingProgress: 0.0)
            savedStories.append(newItem)
        }
    }
}
