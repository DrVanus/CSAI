//
//  ChatMessage.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

// AIChatPageView.swift

import SwiftUI
import Combine

struct ChatMessage: Identifiable {
    let id = UUID()
    let sender: String  // "AI" or "User"
    let text: String
}

class AIChatPageViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [
        ChatMessage(sender: "AI", text: "Hello, how can I assist you today?"),
        ChatMessage(sender: "User", text: "What's the outlook for Bitcoin?"),
        ChatMessage(sender: "AI", text: "Bitcoin appears strong; consider diversifying.")
    ]
    @Published var currentInput: String = ""
    
    func sendMessage() {
        guard !currentInput.isEmpty else { return }
        let userMessage = ChatMessage(sender: "User", text: currentInput)
        messages.append(userMessage)
        currentInput = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let aiResponse = ChatMessage(sender: "AI", text: "This is a simulated response regarding market conditions.")
            self.messages.append(aiResponse)
        }
    }
}

struct AIChatPageView: View {
    @ObservedObject var viewModel = AIChatPageViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.messages) { message in
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
                .padding()
            }
            
            // Input area
            HStack {
                TextField("Ask about crypto...", text: $viewModel.currentInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationBarTitle("AI Chat", displayMode: .inline)
    }
}

struct AIChatPageView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatPageView()
    }
}
