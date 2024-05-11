//
//  LogoView.swift
//  HabitTracker
//
//  Created by Vannesa The on 11/5/2024.
//

import SwiftUI
import SwiftData

struct LogoView: View {
    @State private var navigateToHighScore = false
    var body: some View {
        VStack {
            Image("Logo")
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                navigateToHighScore = true
            }
        }
        .fullScreenCover(isPresented: $navigateToHighScore) {
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
