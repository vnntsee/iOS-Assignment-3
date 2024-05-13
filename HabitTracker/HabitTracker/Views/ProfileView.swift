//
//  ProfileView.swift
//  HabitTracker
//
//  Created by Vannesa The on 6/5/2024.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    // State variable for toggling dark mode
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var currUser: User = User(name: "John Doe", points: 4300, ranking: 2, longestStreak: 55)
    
    var body: some View {
        // Background setup
        ZStack {
            Color(UIColor(named: "PastelYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            // Content layout
            VStack {
                // User's name
                Text("\(currUser.name)")
                    .font(.title)
                    .fontWeight(.black)
                // User's profile image
                Image("DefaultProfile")
                    .padding(.bottom, 20)
                // User's statistics
                VStack (alignment: .leading, spacing: 20) {
                    Text("Points: \(currUser.points)")
                    Text("Longest Streak: \(currUser.longestStreak)")
                    Text("Ranking: \(currUser.ranking)")
                        .padding(.bottom, 20)
                    // Dark mode toggle
                    HStack {
                        Toggle(isOn: $isDarkMode, label: {
                            Text("Dark Mode")
                        })
                    }
                }
                .font(.title3)
                .fontWeight(.semibold)
            }
            .padding(40)
            // Change the colorScheme based on isDarkMode state variable
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return ProfileView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
