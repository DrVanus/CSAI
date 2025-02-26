//
//  ChatMessage.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


import Foundation

struct ChatMessage: Identifiable, Codable {
    let id = UUID()
    let role: String  // "user", "assistant", or "system"
    let content: String
    let timestamp: Date
    
    init(role: String, content: String) {
        self.role = role
        self.content = content
        self.timestamp = Date()
    }
}