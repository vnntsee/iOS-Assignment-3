//
//  Habit.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 3/5/2024.
//

import Foundation
import SwiftData

@Model
class Habit: Identifiable {
    let id: String = UUID().uuidString
    var name: String
    var daysToComplete: [String] //From Mon to Sun, corresponding with each day of the week.
    var priority: Int //1 = High, 2 = Medium, 3 = Low
    var dateCreated: Date
    var isCompleted: Bool //CHANGE: currently only accounts for one day
    
    init(name: String = "", daysToComplete: [String] = [], priority: Int = 3, dateCreated: Date = .now, isCompleted: Bool = false) {
        self.name = name
        self.daysToComplete = daysToComplete
        self.priority = priority
        self.dateCreated = dateCreated
        self.isCompleted = isCompleted
    }
}
