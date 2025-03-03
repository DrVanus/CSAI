//
//  WriteYourOwnStoryView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct WriteYourOwnStoryView: View {
    @State private var storyTitle: String = ""
    @State private var storyGenre: String = ""
    @State private var mainCharacters: String = ""
    @State private var additionalChars: String = ""
    @State private var setting: String = ""
    @State private var plotOutline: String = ""
    
    @State private var scenes: [String] = []
    @State private var newSceneText: String = ""
    
    // Advanced fields
    @State private var showAdvanced = false
    @State private var prologue: String = ""
    @State private var themes: String = ""
    @State private var plotTwists: String = ""
    @State private var possibleEndings: String = ""
    
    @State private var showCustomStoryView = false
    
    let randomPrompts = [
        "A lone astronaut finds an abandoned spaceship drifting near Jupiter.",
        "A royal ball is interrupted by a mysterious messenger.",
        "A detective in a steampunk city uncovers a hidden clockwork cult.",
        "A cursed pirate ship haunts a moonlit bay, seeking lost treasure.",
        "An alchemist’s apprentice accidentally awakens an ancient dragon."
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.2), .blue.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                TopWaveShape()
                    .fill(Color.white.opacity(0.1))
                    .frame(height: 120)
                    .offset(y: -60)
                Spacer()
            }
            
            Form {
                Section(header: Text("STORY BASICS").font(.headline)) {
                    TextField("Title", text: $storyTitle)
                    TextField("Genre (e.g. Fantasy, Sci-Fi)", text: $storyGenre)
                    
                    Button("Random Prompt") {
                        if let random = randomPrompts.randomElement() {
                            plotOutline = random
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                Section(header: Text("CHARACTERS").font(.headline)) {
                    TextField("Main Characters", text: $mainCharacters)
                    TextField("Additional Characters", text: $additionalChars)
                }
                
                Section(header: Text("WORLD DETAILS").font(.headline)) {
                    TextField("Setting (time/place)", text: $setting)
                    TextField("Plot Outline", text: $plotOutline)
                }
                
                Section(header: Text("ADVANCED OPTIONS").font(.headline)) {
                    Toggle("Show Advanced Fields", isOn: $showAdvanced.animation())
                    
                    if showAdvanced {
                        TextField("Prologue", text: $prologue)
                        TextField("Themes", text: $themes)
                        TextField("Plot Twists", text: $plotTwists)
                        TextField("Possible Endings", text: $possibleEndings)
                    }
                }
                
                Section(header: Text("ADD SCENES / CHAPTERS").font(.headline)) {
                    TextField("Scene text...", text: $newSceneText)
                    Button("Add Scene") {
                        guard !newSceneText.isEmpty else { return }
                        scenes.append(newSceneText)
                        newSceneText = ""
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brandSecondary)
                }
                
                if !scenes.isEmpty {
                    Section("SCENES") {
                        ForEach(scenes, id: \.self) { sceneText in
                            Text(sceneText)
                                .padding(.vertical, 4)
                        }
                    }
                }
                
                Section {
                    Button("Begin Story") {
                        showCustomStoryView = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brandPrimary)
                }
            }
            .sheet(isPresented: $showCustomStoryView) {
                CustomUserStoryView(
                    title: storyTitle,
                    genre: storyGenre,
                    characters: mainCharacters,
                    advancedPrologue: prologue
                )
            }
        }
        .navigationBarTitle("Write Your Own Story", displayMode: .inline)
    }
}

struct CustomUserStoryView: View {
    let title: String
    let genre: String
    let characters: String
    let advancedPrologue: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Your Custom Story")
                        .font(.largeTitle.bold())
                    
                    Text("Title: \(title)")
                    Text("Genre: \(genre)")
                    Text("Main Characters: \(characters)")
                    
                    if !advancedPrologue.isEmpty {
                        Text("Prologue:\n\(advancedPrologue)")
                            .padding()
                    }
                }
                .padding()
            }
            .navigationBarTitle("Preview", displayMode: .inline)
        }
    }
}
