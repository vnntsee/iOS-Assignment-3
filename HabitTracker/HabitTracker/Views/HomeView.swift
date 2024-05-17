//
//  ContentView.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                // Background color with pastel yellow
                Color(UIColor(named: "PastelYellowBackground") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all) // Ensures the color covers the entire screen
                HStack {
                    // Login and Sign Up links placed side by side
                    loginLink
                    signUpLink
                }
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .font(.title2)
            .fontWeight(.bold)
        }
    }
}
// Navigation link to LoginView, styled to look like a button
var loginLink: some View {
    NavigationLink (destination: LoginView(), label: {
        ZStack {
            Image(systemName: "hexagon.fill") // Hexagon shape as a background
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .foregroundStyle(Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow)))
            Text("Log In") // Text inside the hexagon
        }
    })
    .padding(.trailing) // Adds padding to the right of the login link
}

// Navigation link to SignUpView, styled to look like a button
var signUpLink: some View {
    NavigationLink (destination: SignUpView(), label: {
        ZStack {
            Image(systemName: "hexagon.fill") // Hexagon shape as a background
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .foregroundStyle(Color(UIColor(named: "MediumYellow") ?? UIColor(Color.orange)))
            Text("Sign Up") // Text inside the hexagon
        }
    })
    .padding(.leading) // Adds padding to the left of the sign-up link
}

#Preview {
    //Stores temporary data for preview.
    do {
        // Configuration for in-memory storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // Creating a model container
        let container = try ModelContainer(for: User.self, configurations: config)
        // Attaches the model container to the view
        return HomeView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
