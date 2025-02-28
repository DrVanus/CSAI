//
//  UserProfileView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//


import SwiftUI

struct UserProfileView: View {
    // Sample user profile data
    @State private var profileImage: Image = Image(systemName: "person.circle.fill")
    @State private var userName: String = "John Doe"
    @State private var userEmail: String = "john.doe@example.com"
    
    var body: some View {
        VStack(spacing: 20) {
            // Profile picture
            profileImage
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .foregroundColor(.blue)
            
            // User name
            Text(userName)
                .font(.title)
                .bold()
            
            // User email
            Text(userEmail)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("") // No unwanted navigation title
        .navigationBarHidden(true)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}