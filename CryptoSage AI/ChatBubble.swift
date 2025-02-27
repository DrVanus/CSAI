//
//  ChatBubble.swift
//  CryptoSage AI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.role == .assistant || message.role == .system {
                // AI or system messages on the left
                VStack(alignment: .leading) {
                    Text(message.content)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(8)
                }
                Spacer()
            } else {
                // user messages on the right
                Spacer()
                VStack(alignment: .trailing) {
                    Text(message.content)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
