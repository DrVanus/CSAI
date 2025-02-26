//
//  HelpSheetView.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//

// HelpSheetView.swift
import SwiftUI

struct HelpSheetView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Help & Information")
                .font(.title)
                .padding()
            
            Text("""
            Welcome to CryptoSage AI!

            1. Enter your OpenAI API key.
            2. Ask anything about crypto or general topics.
            3. This app is built for iPhone, iPad, and Mac.
            4. Speech recognition and text-to-speech features are supported.
            5. Use the menu to switch between models.
            """)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}
