//
//  WebView.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//

// WebView.swift
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let theURL = URL(string: url) {
            let request = URLRequest(url: theURL)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No updates needed
    }
}
