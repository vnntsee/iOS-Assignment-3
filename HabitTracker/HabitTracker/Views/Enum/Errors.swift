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
    // Error case for when the days is not selected.
    case habitDaysUnselected
    // Error case for when the habit name is empty and the days is not selected.
    case habitNameAndDaysEmpty

    var errorMessage: String {
        switch self {
        // Message for when habit name is empty.
        case .habitsNameEmpty:
            return "Please enter your habit name"
        // Message for when the days is not selected.
        case .habitDaysUnselected:
            return "Please select the days you want to complete your habit"
        // Message for when the habit name is empty and the days is not selected.
        case .habitNameAndDaysEmpty:
            return "Please enter the habit name and select the days you want to complete them"
        }
    }
}
