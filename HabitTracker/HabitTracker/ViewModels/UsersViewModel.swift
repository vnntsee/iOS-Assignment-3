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
    
    //Used for login credential validation
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var incorrectDetails: Bool = false
    @Published var loggedIn: Bool = false
    
    @AppStorage("currUserStr") var currUserStr: String = "" //Stores logged in user's username
    
    //Checks database for credentials that match the user's and stores the logged in user's username in currUser.
    //Updates loggedIn and incorrectDetails booleans for automatic navigation to tabBarView and displaying an error message, respectively.
    func validateCredentials(users: [User]) {
        for user in users {
            if user.name == username && user.password == password {
                loggedIn = true
                currUserStr = user.name
            }
        }
        
        if !loggedIn {
            withAnimation {
                incorrectDetails = true
            }
        }
    }
    
    //Returns user whose username matches the inputted one or a default user object if a use with that username is not found in the database.
    func getUser(users: [User]) -> User {
        for user in users {
            if user.name == currUserStr {
                return user
            }
        }
        return User(name: "Default")
    }
    
    func logout() {
        username = ""
        password = ""
        incorrectDetails = false
        loggedIn = false
        currUserStr = ""
    }
    
    //Assigns each user a ranking corresponding to its position in the inputted array, since users in the array are sorted in descending order based on their points.
    //Ordering is done using @Query in LeaderboardView.
    func updateUsersRanking(users: [User]) {
        for index in 0..<users.count {
            users[index].ranking = index + 1
        }
    }
}
