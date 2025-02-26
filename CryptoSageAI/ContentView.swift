// ContentView.swift
import SwiftUI
import AVFoundation
import Foundation
import PDFKit
import Combine
import Speech

struct ContentView: View {
    
    // MARK: - State Variables
    
    @State var conversationContext = ""
    @State private var messageResponse = ""
    @State private var conversationHistory: [String] = []
    @State private var userInput = ""
    @State private var isAnimating = false
    @State private var isWebviewDisplayed = false
    @State private var isListening = false
    @State private var allMessages: [String] = []
    @State private var readingTime: TimeInterval? = nil
    @State private var showApiKeyView = false
    @State private var speechRecognitionEnabled = false
    @State private var showingHelpSheet = false
    @State private var showFullHistorySheet = false
    
    @State private var userApiKey: String? {
        didSet {
            if let userApiKey = userApiKey {
                UserDefaults.standard.set(userApiKey, forKey: "OPENAI_API_KEY")
            } else {
                UserDefaults.standard.removeObject(forKey: "OPENAI_API_KEY")
            }
        }
    }
    
    @State private var modelType = "gpt-3.5-turbo"
    @State private var showModelOptions = false
    @State private var customModelName = ""
    
    @State private var conversationTimestamp = Date()
    
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @State private var textToSpeechEnabled = false
    @State private var pdfData: Data?
    
    // PDFKit
    @State private var showPDFView = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("CryptoSage AI Assistant")) {
                        TextField("Ask a question here!", text: $userInput)
                        
                        Button(action: {
                            Task {
                                await handleSendMessage()
                            }
                        }) {
                            Label("Send", systemImage: "paperplane.fill")
                        }
                        .disabled(userInput.isEmpty)
                        
                        if isAnimating {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                        
                        if !messageResponse.isEmpty {
                            Text("CSAI: \(messageResponse)")
                                .onTapGesture {
                                    UIPasteboard.general.string = messageResponse
                                }
                        }
                    }
                    
                    Section(header: Text("History / PDF Export")) {
                        Button("Show Full History") {
                            showFullHistorySheet = true
                        }
                        .sheet(isPresented: $showFullHistorySheet) {
                            VStack {
                                Text("Conversation History")
                                    .font(.headline)
                                List(conversationHistory, id: \.self) { item in
                                    Text(item)
                                }
                                
                                Button("Export as PDF") {
                                    exportHistoryAsPDF()
                                }
                                .padding()
                            }
                        }
                    }
                    
                    Section(header: Text("Settings")) {
                        Toggle("Speech Recognition", isOn: $speechRecognitionEnabled)
                        Toggle("Text-to-Speech", isOn: $textToSpeechEnabled)
                        
                        Button(action: {
                            showApiKeyView = true
                        }) {
                            Label("Set API Key", systemImage: "key.fill")
                        }
                        
                        HStack {
                            Text("Model Type: \(modelType)")
                            Spacer()
                            Button(action: {
                                showModelOptions.toggle()
                            }) {
                                Image(systemName: "chevron.down")
                            }
                        }
                    }
                    
                    if !customModelName.isEmpty {
                        Section(header: Text("Custom Model Name")) {
                            Text("\(customModelName)")
                        }
                    }
                }
                .navigationTitle("CryptoSage AI")
                .navigationBarTitleDisplayMode(.inline)
                
                // REPLACED .toolbar(.navigationBarTrailing) WITH:
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingHelpSheet = true
                        }) {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                }
                
                .sheet(isPresented: $showingHelpSheet) {
                    HelpSheetView()
                }
                .sheet(isPresented: $showApiKeyView) {
                    ApiKeySheetView(userApiKey: Binding(
                        get: { userApiKey ?? "" },
                        set: { userApiKey = $0 }
                    ))
                }
                .actionSheet(isPresented: $showModelOptions) {
                    ActionSheet(
                        title: Text("Select Model Type"),
                        buttons: [
                            .default(Text("GPT-3.5 Turbo")) { modelType = "gpt-3.5-turbo" },
                            .default(Text("GPT-4")) { modelType = "gpt-4" },
                            .default(Text("GPT-4-32k")) { modelType = "gpt-4-32k" },
                            .default(Text("Custom")) {
                                presentCustomModelAlert()
                            },
                            .cancel()
                        ]
                    )
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    
    // MARK: - PDF Export
    
    func exportHistoryAsPDF() {
        let combinedText = conversationHistory.joined(separator: "\n\n")
        if let data = PDFService.makePDF(from: combinedText) {
            self.pdfData = data
            self.showPDFView = true
        }
    }
    
    // MARK: - Helper Functions
    
    private func getAPIKey() -> String {
        guard let key = userApiKey else {
            showAlert = true
            errorMessage = "No API Key Provided"
            return ""
        }
        return key
    }
    
    private func handleSendMessage() async {
        let userMessage = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        userInput = ""
        guard !userMessage.isEmpty else { return }
        await getGPTResponse(userMessage: userMessage)
    }
    
    func getGPTResponse(userMessage: String) async {
        isAnimating = true
        defer { isAnimating = false }
        
        let prompt = """
        You are CryptoSage AI, ...
        """
        
        let apiKey = getAPIKey()
        guard !apiKey.isEmpty else { return }
        
        let openAIEndpoint = "https://api.openai.com/v1/chat/completions"
        
        let messages = [
            ["role": "system", "content": "You are CryptoSage AI, ..."],
            ["role": "user", "content": userMessage]
        ]
        
        let requestData: [String: Any] = [
            "model": modelType,
            "messages": messages,
            "temperature": 0.7
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            print("Error: Could not convert request data to JSON")
            return
        }
        
        guard let url = URL(string: openAIEndpoint) else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("Error: HTTP \(httpResponse.statusCode)")
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response: \(responseString ?? "")")
                }
                return
            }
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let choices = json?["choices"] as? [[String: Any]],
               let content = choices.first?["message"] as? [String: Any],
               let text = content["content"] as? String {
                DispatchQueue.main.async {
                    self.messageResponse = text
                    self.conversationHistory.append("User: \(userMessage)")
                    self.conversationHistory.append("CSAI: \(text)")
                }
                
                // TTS if enabled
                if textToSpeechEnabled {
                    let utterance = AVSpeechUtterance(string: text)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    let synth = AVSpeechSynthesizer()
                    synth.speak(utterance)
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func presentCustomModelAlert() {
        let alert = UIAlertController(title: "Enter Custom Model Name", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "e.g. custom-model"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let textField = alert.textFields?.first,
               let text = textField.text, !text.isEmpty {
                customModelName = text
                modelType = text
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}
