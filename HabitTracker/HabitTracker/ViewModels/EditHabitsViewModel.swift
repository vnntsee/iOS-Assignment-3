//
//  EditHabitsViewModel.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import Foundation

class EditHabitsViewModel: ObservableObject {
    
    @Published var habitList: [Habit] = [
            Habit(name: "Exercise for 30 mins", daysToComplete: ["Fri","Sat"], priority: 2),
            Habit(name: "Study for 2 hours", daysToComplete: ["Mon","Tue"], priority: 1),
            Habit(name: "Eat 3 fruits", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 2),
            Habit(name: "Practice French", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 3)
        ]
    // some sample habits to get the user started and to have something to show during presentation.
    func filterHabits(by searchHabit: String) -> [Habit] {
        guard !searchHabit.isEmpty else { return habitList }
        return habitList.filter { $0.name.localizedCaseInsensitiveContains(searchHabit) }
        }
    
    func priorityRating(for priority: Int) -> String {
        switch priority {
        case 1:
            return "Low"
        case 2:
            return "Medium"
        default:
            return "High"
        }
    }
    
    
}

