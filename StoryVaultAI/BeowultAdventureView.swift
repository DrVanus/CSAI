//
//  BeowultAdventureView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct BeowulfStorySegment {
    let text: String
    let imageName: String
    let choice1: String
    let choice2: String
    let choice3: String?
}

struct BeowulfAdventureView: View {
    @StateObject private var beowulfService = BeowulfInteractiveService()
    @State private var currentSegment: BeowulfStorySegment = BeowulfStorySegment(
        text: """
        AI: You arrive at Heorot, the great mead-hall of King Hrothgar...
        """,
        imageName: "shield.fill",
        choice1: "Seek an audience with Hrothgar",
        choice2: "Examine the hall for clues",
        choice3: "Wait quietly for Grendel"
    )
    @State private var userInput: String = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer().frame(height: 20)
                    
                    Image(systemName: currentSegment.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.brandPrimary)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(currentSegment.text)
                            .font(.body)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.secondarySystemBackground))
                            .shadow(radius: 2)
                    )
                    .padding(.horizontal, 16)
                    .frame(minHeight: 220)
                    
                    HStack(spacing: 16) {
                        Button(currentSegment.choice1) {
                            handleChoice(currentSegment.choice1)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.brandPrimary)
                        
                        Button(currentSegment.choice2) {
                            handleChoice(currentSegment.choice2)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.brandPrimary)
                        
                        if let c3 = currentSegment.choice3 {
                            Button(c3) {
                                handleChoice(c3)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.brandPrimary)
                        }
                    }
                    
                    Spacer().frame(height: 200)
                }
            }
            .padding(.bottom, 60)
            
            // Pinned chat bar for custom actions
            HStack(spacing: 8) {
                TextField("Enter a custom action...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)
                Button("Submit") {
                    guard !userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                    handleUserInput(userInput)
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(radius: 2)
            )
        }
        .navigationBarTitle("AI Adventure (Beta)", displayMode: .inline)
    }
    
    private func handleChoice(_ choice: String) {
        let next = beowulfService.fetchNextSegment(chosenChoice: choice)
        currentSegment = next
        userInput = ""
    }
    
    private func handleUserInput(_ input: String) {
        let next = beowulfService.fetchNextSegment(userInput: input)
        currentSegment = next
        userInput = ""
    }
}

class BeowulfInteractiveService: ObservableObject {
    func fetchNextSegment(userInput: String? = nil, chosenChoice: String? = nil) -> BeowulfStorySegment {
        if let input = userInput, !input.isEmpty {
            return BeowulfStorySegment(
                text: """
                You typed: "\(input)"
                AI: The gathered warriors turn to you...
                """,
                imageName: "ear.fill",
                choice1: "Explain your plan",
                choice2: "Challenge the warriors",
                choice3: "Remain silent"
            )
        } else if let choice = chosenChoice {
            switch choice {
            case "Seek an audience with Hrothgar":
                return BeowulfStorySegment(
                    text: """
                    King Hrothgar listens gravely...
                    """,
                    imageName: "crown.fill",
                    choice1: "Reassure Hrothgar",
                    choice2: "Ask about Grendel’s weakness",
                    choice3: "Leave to prepare"
                )
            case "Examine the hall for clues":
                return BeowulfStorySegment(
                    text: """
                    You walk the perimeter of Heorot...
                    """,
                    imageName: "magnifyingglass",
                    choice1: "Gather the warriors",
                    choice2: "Set a trap for Grendel",
                    choice3: "Report findings to Hrothgar"
                )
            case "Wait quietly for Grendel":
                return BeowulfStorySegment(
                    text: """
                    Night falls, and the mead-hall grows silent...
                    """,
                    imageName: "moon.fill",
                    choice1: "Ready your weapon",
                    choice2: "Call out to the beast",
                    choice3: "Flee the hall"
                )
            default:
                return BeowulfStorySegment(
                    text: """
                    You chose: \(choice)
                    AI: The epic conflict looms closer...
                    """,
                    imageName: "questionmark.circle",
                    choice1: "Prepare for battle",
                    choice2: "Seek more info",
                    choice3: nil
                )
            }
        } else {
            return BeowulfStorySegment(
                text: """
                AI: You arrive at Heorot...
                """,
                imageName: "shield.fill",
                choice1: "Seek an audience with Hrothgar",
                choice2: "Examine the hall for clues",
                choice3: "Wait quietly for Grendel"
            )
        }
    }
}
