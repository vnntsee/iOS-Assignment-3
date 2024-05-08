//
//  TodayHabitsViewModel.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import Foundation

class TodayHabitsViewModel: ObservableObject {
    //SAMPLE
    @Published var totalTodayHabits: Int = 4
    @Published var numHabitsCompleted: Int = 0
    @Published var completionOpacity: Double = 1
    
    //Decreases opacity by the ratio of the number of habits completed to the total.
    func updateHabitsColour() {
        completionOpacity = 1 - (Double(numHabitsCompleted) / Double(totalTodayHabits))
    }

    func updateHabitsCompleted(habit: Habit) {
        if habit.isCompleted {
            numHabitsCompleted += 1
        }
        else {
            numHabitsCompleted -= 1
        }
    }
}
