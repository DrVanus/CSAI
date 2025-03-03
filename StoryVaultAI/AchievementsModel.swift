//
//  Achievement.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isUnlocked: Bool
}

class AchievementsModel: ObservableObject {
    @Published var achievements: [Achievement] = [
        Achievement(title: "Spooky Fan", description: "Read 3 horror stories", isUnlocked: false),
        Achievement(title: "Treasure Hunter", description: "Complete 5 adventure stories", isUnlocked: false),
        Achievement(title: "Library Explorer", description: "Finish 50% of your saved library", isUnlocked: false)
    ]
    
    // Example function to unlock achievements
    func checkAchievements(library: LibraryModel) {
        // e.g. if user completed 3 horror stories => achievements[index].isUnlocked = true
    }
}
