//
//  AddHabitsViewModel.swift
//  HabitTracker
//
//  Created by Vannesa The on 16/5/2024.
//

import Foundation
import SwiftUI

class AddHabitsViewModel: ObservableObject {
    @AppStorage("Habit Name") var habitName: String = ""
    @Published var errorMessage: String? // Optional error message
    @Published var daysSelected: String = ""
    
    func validateInputs() {
        // Check if habit name is empty.
        let isHabitNameEmpty = habitName.isEmpty
        // Check if days not selected
        let isDaysSelectedIncomplete = daysSelected.isEmpty
        // Determine the appropriate error message based on the validation results.
        switch (isHabitNameEmpty, isDaysSelectedIncomplete) {
            // If all inputs are incomplete.
        case (true, true):
            errorMessage = Errors.habitNameAndDaysEmpty.errorMessage
            // If habit name is empty.
        case (true, _):
            errorMessage = Errors.habitsNameEmpty.errorMessage
            // If days not selected.
        case (_, true):
            errorMessage = Errors.habitDaysUnselected.errorMessage
            // No error message if no errors detected.
        default:
            errorMessage = nil
        }
    }
}
