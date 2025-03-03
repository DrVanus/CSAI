//
//  StoryData.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct StorySegment: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let choices: [Choice]
}

struct Choice: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let destination: String
}

class StoryManager: ObservableObject {
    @Published var segments: [String: StorySegment] = [:]
    @Published var errorMessage: String? = nil
    
    init() {
        loadBasicSegments()
    }
    
    func loadBasicSegments() {
        // If you have a story.json file, load it; otherwise, use fallback data.
        fallbackToDefaultData()
    }
    
    func fallbackToDefaultData() {
        let defaultJSON = """
        [
            {
                "id": "defaultPage",
                "text": "Default story text. There was an error loading the story data.",
                "choices": []
            }
        ]
        """
        if let data = defaultJSON.data(using: .utf8),
           let segmentsArray = try? JSONDecoder().decode([StorySegment].self, from: data) {
            self.segments = Dictionary(uniqueKeysWithValues: segmentsArray.map { ($0.id, $0) })
        }
    }
}
