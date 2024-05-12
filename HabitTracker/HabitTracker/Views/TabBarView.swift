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
                    Image(systemName: "circles.hexagongrid.fill")
                    Text("All Habits")
                }
            // Tab for displaying today's habit
            TodayView()
                .tabItem {
                    Image(systemName: "hexagon.fill")
                    Text("Today's Habit")
                }
            // Tab for displaying the leaderboard
            LeaderboardView()
                .tabItem {
                    Image(systemName: "medal.star.fill")
                    Text("Leaderboard")
                }
            // Tab for displaying the user's profile
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return TabBarView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
