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
                .ignoresSafeArea(.all)
            // Logo image centered vertically
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            // Trigger navigation after 2 seconds
            .onAppear {
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
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return LogoView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
