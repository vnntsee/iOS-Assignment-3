//
//  Errors.swift
//  HabitTracker
//
//  Created by Vannesa The on 16/5/2024.
//

import Foundation

// Enum defining custom errors related to invalid settings
enum Errors: Error {
    // Error case for when habit name is empty.
    case habitsNameEmpty
    // Error case for when the habit's completion days are not selected.
    case habitDaysUnselected
    // Error case for when both the habit name and completion days are empty.
    case habitNameAndDaysEmpty
    
    // Computed property to retrieve the error message for each error case.
    var errorMessage: String {
        switch self {
        // Error message for when the habit name is empty.
        case .habitsNameEmpty:
            return "Please enter your habit name"
        // Error message for when the habit's completion days are not selected.
        case .habitDaysUnselected:
            return "Please select the days you want to complete your habit"
        // Error message for when both the habit name and completion days are empty.
        case .habitNameAndDaysEmpty:
            return "Please enter the habit name and select the days you want to complete them"
        }
    }
}
