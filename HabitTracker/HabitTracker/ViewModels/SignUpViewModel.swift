//
//  SignUpViewModel.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 12/5/2024.
//

import Foundation
import SwiftData

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var signUpErr: String = ""
    @Published var incorrectDetails: Bool = false
    @Published var signedUp: Bool = false
    
    func numbersInString() -> Int {
        var numCounter: Int = 0
        for char in password {
            switch char {
            case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                numCounter += 1
            default:
                numCounter += 0
            }
        }
        return numCounter
    }
    
    func isUsernameValid() -> Bool {
        return username.count >= 4
    }
    
    func isPasswordValid() -> Bool {
        return password.count >= 4 && numbersInString() >= 2
    }
    
    func isEmpty() -> Bool {
        return username.isEmpty || password.isEmpty
    }
    
    func usernameTaken(users: [User]) -> Bool {
        for user in users {
            if user.name == username {
                return true
            }
        }
        return false
    }
    
    func validateCredentials(users: [User]) {
        if isEmpty() {
            signUpErr = "You must enter a username and password!"
            incorrectDetails = true
        }
        else if !isUsernameValid() {
            signUpErr = "Username must contain at least 4 characters."
            incorrectDetails = true
        }
        else if usernameTaken(users: users) {
            signUpErr = "A user is already registered with this username"
            incorrectDetails = true
        }
        else if !isPasswordValid() {
            signUpErr = "Password must contain a minimum of 2 characters and 2 numbers."
            incorrectDetails = true
        }
        else {
            signedUp = true
        }
    }
}
