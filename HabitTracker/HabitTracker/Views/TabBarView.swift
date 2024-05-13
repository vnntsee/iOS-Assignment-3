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
        TabView {
            AllHabitsView()
                .tabItem {
                    Image(systemName: "circles.hexagongrid.fill")
                    Text("All Habits")
                }
            TodayView()
                .tabItem {
                    Image(systemName: "hexagon.fill")
                    Text("Today's Habit")
                }
            LeaderboardView()
                .tabItem {
                    Image(systemName: "medal.star.fill")
                    Text("Leaderboard")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
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
