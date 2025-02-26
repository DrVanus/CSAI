//
//  ContentViewModel.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//

// ContentViewModel.swift
import SwiftUI
import Combine

struct ChatMessage: Identifiable, Codable {
    let id = UUID()
    let role: String  // "user" or "assistant"
    let content: String
    let timestamp: Date = Date()
}

class ContentViewModel: ObservableObject {
    @Published var userInput: String = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false
    @Published var openAIModel: String = "gpt-3.5-turbo"
    @Published var apiKey: String = UserDefaults.standard.string(forKey: "OPENAI_API_KEY") ?? "" {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: "OPENAI_API_KEY")
        }
    }
    
    // Services
    let speechService = MultiPlatformSpeechService()
    let ttsService = MultiPlatformTTSService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Update user input as speech is recognized (if desired)
        speechService.$recognizedText
            .receive(on: RunLoop.main)
            .assign(to: \.userInput, on: self)
            .store(in: &cancellables)
    }
    
    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        guard !apiKey.isEmpty else {
            print("No API key provided")
            return
        }
        
        let newUserMessage = ChatMessage(role: "user", content: userInput)
        messages.append(newUserMessage)
        let currentInput = userInput
        userInput = ""
        isLoading = true
        
        // Dummy async call for OpenAI – replace with your actual networking code.
        Task {
            do {
                // Simulate a network call delay
                try await Task.sleep(nanoseconds: 1_000_000_000)
                let responseContent = "Echo: \(currentInput)"
                let assistantMsg = ChatMessage(role: "assistant", content: responseContent)
                await MainActor.run {
                    self.messages.append(assistantMsg)
                    self.isLoading = false
                    self.ttsService.speak(responseContent)
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
    
    func startSpeechRecognition() {
        speechService.startListening()
    }
    
    func stopSpeechRecognition() {
        speechService.stopListening()
    }
    
    func generateConversationPDF() -> Data? {
        let combinedText = messages.map { "[\($0.role)] \($0.content)" }.joined(separator: "\n\n")
        return PDFService.makePDF(from: combinedText)
    }
}
