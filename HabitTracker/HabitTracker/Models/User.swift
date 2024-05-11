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
    var name: String
    var password: String
    var points: Int
    var ranking: Int
    var longestStreak: Int
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
