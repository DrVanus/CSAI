//
//  MultiPlatformTTSService.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


// MultiPlatformTTSService.swift
#if canImport(UIKit)
import AVFoundation
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

import SwiftUI

class MultiPlatformTTSService: ObservableObject {
    #if targetEnvironment(macCatalyst) || os(iOS)
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String, language: String = "en-US") {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    #elseif os(macOS)
    private let synthesizer = NSSpeechSynthesizer()
    
    func speak(_ text: String) {
        synthesizer.startSpeaking(text)
    }
    
    func stop() {
        synthesizer.stopSpeaking()
    }
    #endif
}