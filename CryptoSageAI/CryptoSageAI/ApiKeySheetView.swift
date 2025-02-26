//
//  ApiKeySheetView.swift
//  CryptoSageAI
//
//  Created by DM on 2/26/25.
//


// ApiKeySheetView.swift
import SwiftUI

struct ApiKeySheetView: View {
    @Binding var userApiKey: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("OpenAI API Key")) {
                    TextField("Enter your key", text: $userApiKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationBarTitle("Set API Key", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
