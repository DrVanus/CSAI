//
//  ChatBubble.swift
//  CryptoSage AI2
//
//  Created by DM on 2/26/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.role == .assistant || message.role == .system {
                // Left-aligned bubble (assistant/system)
                VStack(alignment: .leading) {
                    Text(message.content)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                Spacer()
            } else {
                // Right-aligned bubble (user)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(message.content)
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.yellow.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
        }
    }
}
