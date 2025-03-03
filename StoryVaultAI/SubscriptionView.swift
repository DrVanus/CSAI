//
//  SubscriptionView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var selectedTier: String = "Explorer (Free)"
    
    var body: some View {
        ZStack {
            // System background for a clean look in light/dark mode
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Choose Your Plan")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        
                        // EXPLORER (Free)
                        tierCard(
                            tierName: "Explorer (Free)",
                            displayPrice: "Free",
                            rawPrice: 0.00,
                            features: [
                                "AI Adventure: Basic text-based AI storytelling",
                                "Limited images per day",
                                "Ads: Supported by ads to keep it free"
                            ],
                            isSelected: selectedTier == "Explorer (Free)"
                        )
                        .onTapGesture { selectedTier = "Explorer (Free)" }
                        
                        // STORYTELLER ($9.99/mo)
                        tierCard(
                            tierName: "Storyteller",
                            displayPrice: "$9.99/mo",
                            rawPrice: 9.99,
                            features: [
                                "Ad-Free: Clean, uninterrupted experience",
                                "AI-generated images for immersive storytelling",
                                "Partial AI Chat usage (type some custom responses)"
                            ],
                            isSelected: selectedTier == "Storyteller"
                        )
                        .onTapGesture { selectedTier = "Storyteller" }
                        
                        // VAULT MASTER ($19.99/mo)
                        tierCard(
                            tierName: "Vault Master",
                            displayPrice: "$19.99/mo",
                            rawPrice: 19.99,
                            features: [
                                "All Storyteller features + more",
                                "Unlimited AI Chat usage (type custom responses freely)",
                                "Immersive AI Narration & Character Voices" // Updated bullet
                            ],
                            isSelected: selectedTier == "Vault Master"
                        )
                        .onTapGesture { selectedTier = "Vault Master" }
                    }
                    .padding(.horizontal, 20)
                    
                    // Subscribe / Select button
                    Button(action: {
                        // Placeholder for actual purchase logic
                        print("Selected tier: \(selectedTier)")
                    }) {
                        Text(selectedTier == "Explorer (Free)"
                             ? "Select Explorer"
                             : "Subscribe to \(selectedTier)"
                        )
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer().frame(height: 40)
                }
            }
        }
        .navigationBarTitle("Subscription", displayMode: .inline)
    }
    
    /// Helper that builds a tier card with features
    @ViewBuilder
    private func tierCard(
        tierName: String,
        displayPrice: String,
        rawPrice: Double,
        features: [String],
        isSelected: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(tierName)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                Spacer()
                Text(displayPrice)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 4)
            
            ForEach(features, id: \.self) { feature in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text(feature)
                        .foregroundColor(.primary)
                }
                .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            isSelected
            ? Color(UIColor.secondarySystemFill)
            : Color(UIColor.systemBackground)
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
