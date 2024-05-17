//
//  SignUpViewModel.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 12/5/2024.
//

import Foundation
import SwiftData

class SignUpViewModel: ObservableObject {
    // Published properties for storing user input and state.
    @Published var username: String = "" // User's username
    @Published var password: String = "" // User's password
    @Published var signUpErr: String = "" // Error message for sign-up process
    @Published var incorrectDetails: Bool = false // Flag indicating incorrect sign-up details
    @Published var signedUp: Bool = false // Flag indicating successful sign-up
    
    // Counts the number of digits in the password.
    // - Returns: The count of digits in the password.
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
    
    // Checks if the username is valid, it must contain at least 4 characters.
    func isUsernameValid() -> Bool {
        return username.count >= 4
    }
    
    // Checks if the password is valid, it must contain a minimum of 4 characters and 2 numbers.
    func isPasswordValid() -> Bool {
        return password.count >= 4 && numbersInString() >= 2
    }
    
    // Checks if the username or password is empty.
    func isEmpty() -> Bool {
        return username.isEmpty || password.isEmpty
    }
    
    // Checks if the username is already taken.
    func usernameTaken(users: [User]) -> Bool {
        for user in users {
            if user.name == username {
                return true
            }
        }
        return false
    }
    
    // Validates the provided sign-up credentials.
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
