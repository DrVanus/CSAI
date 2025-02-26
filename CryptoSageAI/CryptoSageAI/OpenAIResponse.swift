//
//  OpenAIResponse.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


import Foundation

struct OpenAIResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    
    struct Choice: Codable {
        let index: Int
        let message: Message
        let finishReason: String?
        
        struct Message: Codable {
            let role: String
            let content: String
        }
    }
    
    let usage: Usage?
    
    struct Usage: Codable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int
    }
}