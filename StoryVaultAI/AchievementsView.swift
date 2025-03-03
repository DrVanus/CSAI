//
//  AchievementsView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var achievementsModel: AchievementsModel
    
    var body: some View {
        List {
            ForEach(achievementsModel.achievements) { achievement in
                HStack {
                    if achievement.isUnlocked {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(achievement.title)
                            .font(.headline)
                        Text(achievement.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Achievements")
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
            .environmentObject(AchievementsModel())
    }
}
