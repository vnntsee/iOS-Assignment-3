//
//  ContentView.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                NavigationLink (
                    destination: LeaderboardView(),
                    label: {
                        Text("Leaderboard")
                            .font(.title)
                    }
                )
                NavigationLink (
                    destination: TodayView(),
                    label: {
                        Text("Today's Habits")
                            .font(.title)
                    }
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
