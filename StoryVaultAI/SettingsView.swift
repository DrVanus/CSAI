//
//  SettingsView.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var contentFilter: String = "All"
    @State private var textSize: Double = 16
    
    var body: some View {
        Form {
            Section(header: Text("Content Filter")) {
                Picker("Filter Level", selection: $contentFilter) {
                    Text("All").tag("All")
                    Text("PG-13").tag("PG13")
                    Text("Mature").tag("Mature")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Reading Options")) {
                HStack {
                    Text("Text Size: \(Int(textSize))")
                    Spacer()
                    Slider(value: $textSize, in: 12...24, step: 1)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
