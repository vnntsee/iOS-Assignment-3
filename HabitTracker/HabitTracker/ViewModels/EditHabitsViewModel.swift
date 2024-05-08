//
//  EditHabitsViewModel.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import Foundation

class EditHabitsViewModel: ObservableObject {
    
    @Published var habitList: [Habit] = [
            Habit(name: "Exercise for 30 mins", daysToComplete: [5,6], priority: 2),
            Habit(name: "Study for 2 hours", daysToComplete: [0,2], priority: 1),
            Habit(name: "Eat 3 fruits", daysToComplete: [0,1,2,3,4,5,6], priority: 2),
            Habit(name: "Practice French", daysToComplete: [0,1,2,3,4,5,6], priority: 3)
        ]

        func filterHabits(by searchHabit: String) -> [Habit] {
            guard !searchHabit.isEmpty else { return habitList }
            return habitList.filter { $0.name.localizedCaseInsensitiveContains(searchHabit) }
        }
}
