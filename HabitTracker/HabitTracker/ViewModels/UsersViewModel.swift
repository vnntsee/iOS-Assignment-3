//
//  UsersViewModel.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 9/5/2024.
//

import Foundation
import SwiftData
import SwiftUI

class UsersViewModel: ObservableObject {
    
    //Assigns each user a ranking corresponding to its position in the inputted array, since users in the array are sorted in descending order based on their points.
    //Ordering is done using @Query in LeaderboardView.
    func updateUsersRanking(users: [User]) {
        for index in 0..<users.count {
            users[index].ranking = index + 1
        }
    }
    
}
