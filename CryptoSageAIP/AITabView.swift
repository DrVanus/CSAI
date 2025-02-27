//
//  AITabView.swift
//  CryptoSageAIP
//
//  Created by DM on 2/27/25.
//


import SwiftUI
import Speech
import AVFoundation

struct AITabView: View {
    @EnvironmentObject var appState: AppState
    @State private var messages: [ChatMessage] = [
        ChatMessage(role: .system, content: "Welcome to CryptoSage AI! Ask anything about crypto.")
    ]
    @State private var userInput: String = ""
    @FocusState private var isInputFocused: Bool
    @State private var isRecording = false
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(messages) { msg in
                                ChatBubble(message: msg)
                                    .id(msg.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .frame(maxWidth: 800)
                        .onChange(of: messages.count) { _ in
                            if let lastID = messages.last?.id {
                                withAnimation {
                                    scrollProxy.scrollTo(lastID, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                .background(Color.black)
                inputArea
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarTitle("AI Chat", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear Chat") {
                        messages.removeAll()
                        saveChatHistory()
                    }
                }
            }
            .onAppear {
                loadChatHistory()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var inputArea: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(presetPrompts, id: \.self) { prompt in
                        Button(prompt) {
                            userInput = prompt
                            isInputFocused = false
                        }
                        .padding(6)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
            .background(Color.black)
            HStack(spacing: 4) {
                ZStack {
                    if userInput.isEmpty {
                        Text("Ask anything about crypto...")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    TextEditor(text: $userInput)
                        .frame(minHeight: 36, maxHeight: 80)
                        .padding(4)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .focused($isInputFocused)
                }
                Button {
                    sendMessage()
                    isInputFocused = false
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(8)
                }
                Button {
                    UIApplication.shared.endEditing()
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
                Button {
                    toggleRecording()
                } label: {
                    Image(systemName: isRecording ? "mic.fill" : "mic")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isRecording ? .red : .white)
                        .padding(6)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding(6)
            .background(Color.black)
            .padding(.bottom, 80)
        }
    }

    let presetPrompts = [
        "What are today’s biggest crypto gainers?",
        "What's my portfolio’s risk level?",
        "Explain BTC’s price movement in the last 24 hours."
    ]

    func sendMessage() {
        guard !userInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let userMsg = ChatMessage(role: .user, content: userInput)
        messages.append(userMsg)
        userInput = ""
        saveChatHistory()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiReply = ChatMessage(role: .assistant, content: "This is a placeholder AI response.")
            messages.append(aiReply)
            saveChatHistory()
        }
    }

    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
        isRecording.toggle()
    }

    func startRecording() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == .authorized {
                do {
                    let audioSession = AVAudioSession.sharedInstance()
                    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                    let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                    let inputNode = audioEngine.inputNode
                    recognitionRequest.shouldReportPartialResults = true
                    recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                        if let result = result {
                            DispatchQueue.main.async {
                                self.userInput = result.bestTranscription.formattedString
                            }
                        }
                        if error != nil || (result?.isFinal ?? false) {
                            self.audioEngine.stop()
                            inputNode.removeTap(onBus: 0)
                            recognitionTask = nil
                        }
                    }
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                        recognitionRequest.append(buffer)
                    }
                    audioEngine.prepare()
                    try audioEngine.start()
                } catch {
                    print("Error starting recording: \(error.localizedDescription)")
                }
            } else {
                print("Speech recognition not authorized.")
            }
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        recognitionTask = nil
    }

    func saveChatHistory() {
        let mapped = messages.map { ["role": $0.roleString, "content": $0.content] }
        do {
            let data = try JSONSerialization.data(withJSONObject: mapped, options: [])
            UserDefaults.standard.set(data, forKey: "aiChatHistory")
        } catch {
            print("Error encoding chat messages: \(error)")
        }
    }

    func loadChatHistory() {
        guard let data = UserDefaults.standard.data(forKey: "aiChatHistory") else { return }
        do {
            let raw = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] ?? []
            let restored = raw.compactMap { dict -> ChatMessage? in
                guard let roleString = dict["role"], let content = dict["content"] else { return nil }
                let role: MessageRole = (roleString == "assistant") ? .assistant : (roleString == "system" ? .system : .user)
                return ChatMessage(role: role, content: content)
            }
            messages = restored
        } catch {
            print("Error decoding chat messages: \(error)")
        }
    }
}