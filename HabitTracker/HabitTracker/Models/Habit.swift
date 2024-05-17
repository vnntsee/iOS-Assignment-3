//
//  Habit.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 3/5/2024.
//

import Foundation
import SwiftData

@Model //facilitates persistent storage
class Habit: Identifiable {
    let id: String = UUID().uuidString // Unique identifier for the habit
    var name: String // Name of the habit
    var daysToComplete: [String] // Days of the week on which the habit should be completed (from Mon to Sun)
    var priority: Int // Priority level of the habit (1 = High, 2 = Medium, 3 = Low)
    var dateCreated: Date // Date when the habit was created
    var isCompleted: Bool //CHANGE: currently only accounts for one day
    
    // Initializes habit with the provided parameters.
    init(name: String = "", daysToComplete: [String] = [], priority: Int = 3, dateCreated: Date = .now, isCompleted: Bool = false) {
        self.name = name
        self.daysToComplete = daysToComplete
        self.priority = priority
        self.dateCreated = dateCreated
        self.isCompleted = isCompleted
    }
}
