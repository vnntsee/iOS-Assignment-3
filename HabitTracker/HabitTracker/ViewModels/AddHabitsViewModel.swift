//
//  AddHabitsViewModel.swift
//  HabitTracker
//
//  Created by Vannesa The on 16/5/2024.
//

import Foundation
import SwiftUI

class AddHabitsViewModel: ObservableObject {
    // App storage property to store the habit name.
    @AppStorage("Habit Name") var habitName: String = ""
    // Published property for displaying error messages.
    @Published var errorMessage: String?
    // Published property for storing the selected days.
    @Published var daysSelected: String = ""
    
    // Validates the input fields and sets the appropriate error message if any.
    func validateInputs() {
        // Check if habit name is empty.
        let isHabitNameEmpty = habitName.isEmpty
        // Check if days are not selected
        let isDaysSelectedIncomplete = daysSelected.isEmpty
        // Determine the appropriate error message based on the validation results.
        switch (isHabitNameEmpty, isDaysSelectedIncomplete) {
            // If both habit name and days are empty.
        case (true, true):
            errorMessage = Errors.habitNameAndDaysEmpty.errorMessage
            // If habit name is empty.
        case (true, _):
            errorMessage = Errors.habitsNameEmpty.errorMessage
            // If days are not selected.
        case (_, true):
            errorMessage = Errors.habitDaysUnselected.errorMessage
            // No error message if no errors detected.
        default:
            errorMessage = nil
        }
    }
}
