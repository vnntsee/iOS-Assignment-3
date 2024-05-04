//
//  Habit.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 3/5/2024.
//

import Foundation
import SwiftData

//@Model
class Habit: Identifiable {
    let id: String = UUID().uuidString
    var name: String
    var daysToComplete: [Int] //From 0 to 6, corresponding with each day of the week.
    var priority: Int //1 = High, 2 = Medium, 3 = Low
    var dateCreated: Date
    @Published var isCompleted: Bool //CHANGE: currently only accounts for one day
    
    init(name: String = "", daysToComplete: [Int] = [], priority: Int = 3, dateCreated: Date = .now, isCompleted: Bool = false) {
        self.name = name
        self.daysToComplete = daysToComplete
        self.priority = priority
        self.dateCreated = dateCreated
        self.isCompleted = isCompleted
    }
}
