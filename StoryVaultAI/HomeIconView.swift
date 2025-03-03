//
//  HomeIconView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct HomeIconView: View {
    var body: some View {
        ZStack {
            // Background book icon
            Image(systemName: "book.fill")
                .font(.system(size: 24))
                .foregroundColor(.primary)
            // Smaller house icon overlay
            Image(systemName: "house.fill")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .offset(y: 6)  // Adjust vertical offset as needed
        }
    }
}

struct HomeIconView_Previews: PreviewProvider {
    static var previews: some View {
        HomeIconView()
    }
}