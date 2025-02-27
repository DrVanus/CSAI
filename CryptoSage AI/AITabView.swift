//
//  AITabView 2.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct AITabView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    @State private var userInput: String = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(homeVM.messages) { msg in
                                    ChatBubble(message: msg)
                                        .id(msg.id)
                                }
                            }
                            .padding(.top, 8)
                        }
                        .onChange(of: homeVM.messages.count) { _ in
                            if let lastID = homeVM.messages.last?.id {
                                withAnimation {
                                    proxy.scrollTo(lastID, anchor: .bottom)
                                }
                            }
                        }
                    }
                    // input area
                    HStack {
                        ZStack(alignment: .leading) {
                            if userInput.isEmpty {
                                Text("Ask anything about crypto...")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                            }
                            TextEditor(text: $userInput)
                                .frame(minHeight: 40, maxHeight: 80)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .focused($isInputFocused)
                        }
                        // Send button
                        Button(action: sendMessage) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.black)
                }
            }
            .navigationBarTitle("AI Chat", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        homeVM.sendUserMessage(userInput)
        userInput = ""
        isInputFocused = false
    }
}

struct AITabView_Previews: PreviewProvider {
    static var previews: some View {
        AITabView(homeVM: HomeViewModel())
    }
}
