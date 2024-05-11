//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftData
import SwiftUI

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            LogoView()
        }
        .modelContainer(for: User.self)
    }
}
