//
//  SignUpView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                signUpTitle
                Spacer()
            }
        }
    }
}

var signUpTitle: some View {
    Text("Sign Up")
        .font(.title)
        .fontWeight(.bold)
        .padding()
}

var nameField: some View {
    Text("Placeholder")
    //TextField("Enter your name", $)
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return SignUpView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
