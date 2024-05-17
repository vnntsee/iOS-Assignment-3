//
//  User.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 2/5/2024.
//

import Foundation
import SwiftData

@Model //facilitates persistent storage
class User: Identifiable {
    var name: String // Name of the user
    var password: String // The user's password
    var points: Int // Total points earned by the user
    var ranking: Int // Ranking position of the user
    var longestStreak: Int // Longest streak of completed habits by the user
    //@Relationship with cascade delete rule allows for all habits associated with a user to be deleted when they are.
    @Relationship(deleteRule: .cascade) var habits = [Habit]() //Calls default initialiser.
    
    //NOTE: Initialise ranking to last position.
    init(name: String = "", password: String = "", points: Int = 0, ranking: Int = 0, longestStreak: Int = 0) {
        self.name = name
        self.password = password
        self.points = points
        self.ranking = ranking
        self.longestStreak = longestStreak
    }
}
