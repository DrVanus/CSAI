//
//  ProfileView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("darkMode") private var darkMode = false
    
    @State private var username: String = "Profile"
    @State private var subscriptionTier: String = "Free"
    
    @EnvironmentObject var achievementsModel: AchievementsModel
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // System background
                Color(UIColor.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Top Profile Card
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.brandPrimary)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(username)
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                Text("Tier: \(subscriptionTier)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 8)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Achievements / Stats / Upgrade tiles (all brandPrimary gradient)
                    HStack(spacing: 12) {
                        
                        // Achievements
                        NavigationLink(destination: AchievementsView().environmentObject(achievementsModel)) {
                            gradientTile(
                                iconName: "rosette",
                                title: "Achievements"
                            )
                        }
                        
                        // Stats
                        NavigationLink(destination: StatsView().environmentObject(library)) {
                            gradientTile(
                                iconName: "chart.bar.fill",
                                title: "Stats"
                            )
                        }
                        
                        // Upgrade
                        NavigationLink(destination: SubscriptionView()) {
                            gradientTile(
                                iconName: "star.fill",
                                title: "Upgrade"
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Account Management
                    List {
                        Section {
                            Toggle("Dark Mode", isOn: $darkMode)
                            NavigationLink("Settings") {
                                SettingsView()
                            }
                            Button("Logout") {
                                // placeholder
                            }
                            .foregroundColor(.red)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(darkMode ? .dark : .light)
    }
    
    /// Single color gradient tile for Achievements, Stats, Upgrade
    private func gradientTile(iconName: String, title: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(.white)
            Text(title)
                .font(.footnote)
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
        .frame(width: 100, height: 70)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    .brandPrimary,  // start
                    Color.brandPrimary.opacity(0.8)  // end
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AchievementsModel())
            .environmentObject(LibraryModel())
    }
}
