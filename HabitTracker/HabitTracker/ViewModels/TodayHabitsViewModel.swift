//
//  TodayHabitsViewModel.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import Foundation

class TodayHabitsViewModel: ObservableObject {
    //SAMPLE
//    @Published var totalTodayHabits: Int = 4
//    @Published var numHabitsCompleted: Int = 0
//    @Published var completionOpacity: Double = 1
//    
//    //Decreases opacity by the ratio of the number of habits completed to the total.
//    func updateHabitsColour() {
//        completionOpacity = 1 - (Double(numHabitsCompleted) / Double(totalTodayHabits))
//    }
//
//    func updateHabitsCompleted(habit: Habit) {
//        if habit.isCompleted {
//            numHabitsCompleted += 1
//        }
//        else {
//            numHabitsCompleted -= 1
//        }
//    }
    
    func pointsUpdateAmount(habit: Habit) -> Int {
        var updateAmount: Int = 0
        if habit.priority == 1 {
            updateAmount = 10
        }
        else if habit.priority == 2 {
            updateAmount = 15
        }
        else if habit.priority == 3 {
            updateAmount = 20
        }
        if habit.isCompleted {
            return updateAmount
        }
        return -updateAmount
    }
}
