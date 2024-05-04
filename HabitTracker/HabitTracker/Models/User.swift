//
//  User.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 2/5/2024.
//

import Foundation
import SwiftData
import SwiftUI

//@Model //facilitates persistent storage
class User: Identifiable {
    var name: String
    var points: Int
    var ranking: Int
    var longestStreak: Int
    var profilePhoto: Image
    //@Relationship with cascade delete rule allows for all habits associated with a user to be deleted when they are.
    @Relationship(deleteRule: .cascade) var habits = [Habit]() //Calls default initialiser.
    
    //NOTE: Initialise ranking to last position.
    init(name: String = "", points: Int = 0, ranking: Int = -1, longestStreak: Int = 0, profilePhoto: Image = Image("DefaultProfile")) {
        self.name = name
        self.points = points
        self.ranking = ranking
        self.longestStreak = longestStreak
        self.profilePhoto = profilePhoto
    }
}
