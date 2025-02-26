//
//  OpenAIService.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


import Foundation

struct OpenAIService {
    
    enum OpenAIError: Error, LocalizedError {
        case invalidURL
        case invalidResponse(statusCode: Int, responseBody: String?)
        case noContent
        case emptyMessage
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid OpenAI URL."
            case .invalidResponse(let code, let body):
                return "OpenAI API Error.\nHTTP \(code)\n\(body ?? "")"
            case .noContent:
                return "No content in OpenAI response."
            case .emptyMessage:
                return "User message is empty."
            }
        }
    }
    
    static func sendChat(
        messages: [ChatMessage],
        model: String,
        apiKey: String
    ) async throws -> String {
        
        // Convert your ChatMessage array into the JSON format for ChatCompletion
        let openAIEndpoint = "https://api.openai.com/v1/chat/completions"
        guard let url = URL(string: openAIEndpoint) else {
            throw OpenAIError.invalidURL
        }
        
        let messageDictionaries = messages.map { msg in
            ["role": msg.role, "content": msg.content]
        }
        
        let requestData: [String: Any] = [
            "model": model,
            "messages": messageDictionaries,
            "temperature": 0.7
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenAIError.invalidResponse(statusCode: 0, responseBody: "No HTTP response")
        }
        guard httpResponse.statusCode == 200 else {
            let bodyString = String(data: data, encoding: .utf8)
            throw OpenAIError.invalidResponse(statusCode: httpResponse.statusCode, responseBody: bodyString)
        }
        
        // Decode to your OpenAIResponse struct, or do manual parsing
        let decoder = JSONDecoder()
        let openAIResp = try decoder.decode(OpenAIResponse.self, from: data)
        
        guard
            let firstChoice = openAIResp.choices.first,
            !firstChoice.message.content.isEmpty
        else {
            throw OpenAIError.noContent
        }
        
        return firstChoice.message.content
    }
}