//
//  TabBarView.swift
//  HabitTracker
//
//  Created by Vannesa The on 7/5/2024.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    var body: some View {
        // TabView containing tabs for different views
        TabView {
            // Tab for displaying all habits
            AllHabitsView()
                .tabItem {
                    Image(systemName: "circles.hexagongrid.fill") // Icon for the "All Habits" tab
                    Text("All Habits") // Label for the "All Habits" tab
                }
            // Tab for displaying today's habit
            TodayView()
                .tabItem {
                    Image(systemName: "hexagon.fill") // Icon for the "Today's Habit" tab
                    Text("Today's Habit") // Label for the "Today's Habit" tab
                }
            // Tab for displaying the leaderboard
            LeaderboardView()
                .tabItem {
                    Image(systemName: "medal.star.fill") // Icon for the "Leaderboard" tab
                    Text("Leaderboard") // Label for the "Leaderboard" tab
                }
            // Tab for displaying the user's profile
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true) // Hides the back button in the navigation bar
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
        return TabBarView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
