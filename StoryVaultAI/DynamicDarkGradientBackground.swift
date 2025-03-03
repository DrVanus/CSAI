//
//  DynamicDarkGradientBackground.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct DynamicDarkGradientBackground: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            // Increase the oscillation amplitude for a more visible effect.
            let shift = sin(now / 10) * 0.3
            // Base dark colors that will shift noticeably.
            let color1 = Color(red: 0.05 + shift, green: 0.05, blue: 0.15)
            let color2 = Color(red: 0.1, green: 0.05, blue: 0.2 + shift)
            LinearGradient(
                gradient: Gradient(colors: [color1, color2]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

struct DynamicDarkGradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        DynamicDarkGradientBackground()
    }
}