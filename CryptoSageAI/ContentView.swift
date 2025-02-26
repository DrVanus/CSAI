// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    // Sheet toggles
    @State private var showingHelpSheet = false
    @State private var showingApiKeySheet = false
    @State private var showingWebView = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Show messages in a List
                List(viewModel.messages) { msg in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(msg.role.uppercased())")
                            .font(.caption)
                            .foregroundColor(msg.role == "user" ? .blue : .red)
                        Text(msg.content)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                // Input field + send button
                HStack {
                    TextField("Type your message...", text: $viewModel.userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding(.horizontal, 4)
                    }
                    
                    Button(action: {
                        viewModel.sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                    }
                    .disabled(viewModel.isLoading)
                }
                .padding()
            }
            .navigationTitle("CryptoSage AI")
            .toolbar {
                // Left side: Model selection menu
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button("GPT-3.5-Turbo") { viewModel.openAIModel = "gpt-3.5-turbo" }
                        Button("GPT-4") { viewModel.openAIModel = "gpt-4" }
                        Button("GPT-4-32k") { viewModel.openAIModel = "gpt-4-32k" }
                        Button("Set Custom Model...") {
                            // Implement custom model selection here if desired
                        }
                    } label: {
                        Text("Model: \(viewModel.openAIModel)")
                    }
                }
                
                // Right side: multiple toolbar items
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingHelpSheet = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingApiKeySheet = true
                    } label: {
                        Image(systemName: "key.fill")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingWebView = true
                    } label: {
                        Image(systemName: "globe")
                    }
                }
            }
            // Present sheets
            .sheet(isPresented: $showingHelpSheet) {
                HelpSheetView()
            }
            .sheet(isPresented: $showingApiKeySheet) {
                ApiKeySheetView(userApiKey: $viewModel.apiKey)
            }
            .sheet(isPresented: $showingWebView) {
                WebView(url: "https://cryptosage.ai")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
