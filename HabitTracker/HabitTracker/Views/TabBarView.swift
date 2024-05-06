//
//  TabBarView.swift
//  HabitTracker
//
//  Created by Vannesa The on 7/5/2024.
//

import SwiftUI

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
    }
}

#Preview {
    TabBarView()
}
