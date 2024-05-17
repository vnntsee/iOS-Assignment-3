//
//  LogoView.swift
//  HabitTracker
//
//  Created by Vannesa The on 11/5/2024.
//

import SwiftUI
import SwiftData

struct LogoView: View {
    // State variable to control navigation to the home view
    @State private var navigateToHome = false
    var body: some View {
        ZStack {
            // Background color with light yellow
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all) // Ensures the color covers the entire screen
            
            // Logo image centered vertically
            VStack {
                Image("Logo") // Displays the logo image
                    .imageScale(.large) // Sets the image scale to large
                    .foregroundStyle(.tint) // Applies a tint style to the image
            }
            // Trigger navigation after 2 seconds
            .onAppear {
                // Sets navigateToHome to true after 2 seconds
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    navigateToHome = true
                }
            }
        }
        // Navigate to home view when state variable becomes true
        .fullScreenCover(isPresented: $navigateToHome) {
            HomeView()
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        // Configuration for in-memory storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // Creating a model container
        let container = try ModelContainer(for: User.self, configurations: config)
        // Attaches the model container to the view
        return LogoView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
