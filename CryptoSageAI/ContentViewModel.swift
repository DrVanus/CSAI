//
//  ContentViewModel.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//

// ContentViewModel.swift
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var userInput: String = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false
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
        speechService.$recognizedText
            .receive(on: RunLoop.main)
            .assign(to: \.userInput, on: self)
            .store(in: &cancellables)
    }
    
    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newUserMessage = ChatMessage(role: "user", content: userInput)
        messages.append(newUserMessage)
        userInput = ""
        isLoading = true
        
        Task {
            do {
                // Simulate network delay
                try await Task.sleep(nanoseconds: 1_000_000_000)
                let reply = "Echo: \(newUserMessage.content)"
                let assistantMsg = ChatMessage(role: "assistant", content: reply)
                
                await MainActor.run {
                    messages.append(assistantMsg)
                    isLoading = false
                    ttsService.speak(reply)
                }
            } catch {
                await MainActor.run {
                    isLoading = false
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
    
    func generatePDF() {
        // Call your PDFService here if needed.
    }
}
