//
//  ContentView.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @State private var navigateToTabBarView = false
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .onAppear {
                        // Start a timer to wait for a short duration before navigating to HighScoreView
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            navigateToTabBarView = true
                        }
                    }
                // Display the TabBarView fullscreen when navigateToTabBarView is true.
                    .fullScreenCover(isPresented: $navigateToTabBarView) {
                        TabBarView()
                    }
                
//                NavigationLink (destination: SignUpView(), label: {
//                    Text("Sign Up")
//                })
//                
//                NavigationLink (destination: TabBarView(), label: {
//                    Text("TabBarView")
//                })
            }
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return HomeView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
