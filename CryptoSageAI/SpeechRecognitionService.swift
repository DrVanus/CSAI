//
//  SpeechRecognitionService.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


import Foundation
import AVFoundation
import Speech
import Combine

class SpeechRecognitionService: NSObject, ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isListening: Bool = false
    
    private let audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private let request = SFSpeechAudioBufferRecognitionRequest()
    
    override init() {
        super.init()
    }
    
    func startListening() {
        guard !isListening else { return }
        isListening = true
        
        // Request permission
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus != .authorized {
                    // Handle no permission
                    self.isListening = false
                    return
                }
                self.beginSession()
            }
        }
    }
    
    private func beginSession() {
        let inputNode = audioEngine.inputNode
        
        // Configure audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session error: \(error.localizedDescription)")
            return
        }
        
        request.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.recognizedText = result.bestTranscription.formattedString
                }
            }
            if error != nil || (result?.isFinal ?? false) {
                self.stopListening() 
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("AudioEngine start error: \(error.localizedDescription)")
        }
    }
    
    func stopListening() {
        guard isListening else { return }
        isListening = false
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session deactivation error: \(error.localizedDescription)")
        }
    }
}