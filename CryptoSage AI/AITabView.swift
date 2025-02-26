//
//  AITabView 2.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

@available(iOS 16.0, *)
struct AITabView: View {
    @EnvironmentObject var appState: AppState
    
    // Local states for AI chat
    @State private var messages: [ChatMessage] = []
    @State private var userInput: String = ""
    @FocusState private var isInputFocused: Bool
    @State private var isRecording = false
    // Include any speech recognition states if needed
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(messages) { msg in
                                ChatBubble(message: msg)
                                    .id(msg.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .onChange(of: messages.count) { _ in
                            if let lastID = messages.last?.id {
                                withAnimation {
                                    scrollProxy.scrollTo(lastID, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                .background(Color.black)
                
                // Input area for AI chat
                VStack(spacing: 0) {
                    // Preset prompts (if any)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(presetPrompts, id: \.self) { prompt in
                                Button(prompt) {
                                    userInput = prompt
                                    isInputFocused = false
                                }
                                .padding(6)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    }
                    .background(Color.black)
                    
                    HStack(spacing: 4) {
                        ZStack {
                            if userInput.isEmpty {
                                Text("Ask anything about crypto...")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            TextEditor(text: $userInput)
                                .frame(minHeight: 36, maxHeight: 80)
                                .padding(4)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .focused($isInputFocused)
                        }
                        
                        // Send button
                        Button {
                            sendMessage()
                            isInputFocused = false
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(8)
                        }
                        
                        // Dismiss keyboard button
                        Button {
                            UIApplication.shared.endEditing()
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                        }
                        
                        // Mic button
                        Button(action: { toggleRecording() }) {
                            Image(systemName: isRecording ? "mic.fill" : "mic")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(isRecording ? .red : .white)
                                .padding(6)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                        }
                    }
                    .padding(6)
                    .background(Color.black)
                    .padding(.bottom, 80)
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarTitle("AI Chat", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear Chat") {
                        messages.removeAll()
                        saveChatHistory()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            loadChatHistory()
            if !messages.contains(where: { $0.role == .system }) {
                messages.insert(ChatMessage(role: .system, content: "Welcome to CryptoSage AI! Ask anything about crypto."), at: 0)
                saveChatHistory()
            }
        }
    }
    
    let presetPrompts = [
        "What are today’s biggest crypto gainers?",
        "What's my portfolio’s risk level?",
        "Explain BTC’s price movement in the last 24 hours."
    ]
    
    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let userMsg = ChatMessage(role: .user, content: userInput)
        messages.append(userMsg)
        userInput = ""
        saveChatHistory()
        // Placeholder: simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiReply = ChatMessage(role: .assistant, content: "This is a placeholder AI response.")
            messages.append(aiReply)
            saveChatHistory()
        }
    }
    
    func toggleRecording() {
        // Implement speech recognition toggling here (or call your SpeechService)
        isRecording.toggle()
    }
    
    func saveChatHistory() {
        // Implement chat persistence (e.g., using UserDefaults)
    }
    
    func loadChatHistory() {
        // Implement loading chat history
    }
}

struct AITabView_Previews: PreviewProvider {
    static var previews: some View {
        AITabView().environmentObject(AppState())
    }
}