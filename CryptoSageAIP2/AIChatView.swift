//
//  ChatMessage.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

// AIChatView.swift

import SwiftUI
import Combine

// NO ChatMessage struct here anymore!

class AIChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [  // uses ChatMessage from AIChatPageView
        ChatMessage(sender: "AI", text: "Hello! How can I help you with your crypto portfolio today?"),
        ChatMessage(sender: "User", text: "Should I buy more Bitcoin now?"),
        ChatMessage(sender: "AI", text: "You may want to diversify to manage risk.")
    ]
    
    @Published var currentInput: String = ""
    
    func sendMessage() {
        guard !currentInput.isEmpty else { return }
        let userMessage = ChatMessage(sender: "User", text: currentInput)
        messages.append(userMessage)
        currentInput = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let aiResponse = ChatMessage(sender: "AI", text: "Simulated response from the AI regarding your question.")
            self.messages.append(aiResponse)
        }
    }
}

struct AIChatView: View {
    @ObservedObject var viewModel = AIChatViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("AI Chat (Lite)")
                .font(.headline)
                .padding(.top, 8)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.messages) { message in
                        chatBubble(for: message)
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                TextField("Ask the AI about crypto...", text: $viewModel.currentInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .padding(.bottom, 8)
    }
    
    private func chatBubble(for message: ChatMessage) -> some View {
        HStack(alignment: .top) {
            if message.sender == "AI" {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(Text("AI").foregroundColor(.white).font(.caption))
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 30, height: 30)
                    .overlay(Text("U").foregroundColor(.white).font(.caption))
            }
            
            Text(message.text)
                .padding(8)
                .background(message.sender == "AI" ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Spacer()
        }
    }
}

struct AIChatView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatView()
    }
}
