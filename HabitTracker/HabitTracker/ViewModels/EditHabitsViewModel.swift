//
//  EditHabitsViewModel.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import Foundation

class EditHabitsViewModel: ObservableObject {
    // Boolean flag to track if editing is in progress
    @Published var editPressed = false
    // some sample habits to get the user started and to have something to show during presentation.
    @Published var habitList: [Habit] = [
        Habit(name: "Exercise for 30 mins", daysToComplete: ["Fri","Sat"], priority: 2, dateCreated: .now, isCompleted: false),
            Habit(name: "Study for 2 hrs", daysToComplete: ["Mon","Tue"], priority: 1, dateCreated: .now, isCompleted: false),
            Habit(name: "Eat 3 fruits", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 2, dateCreated: .now, isCompleted: false),
            Habit(name: "Practice French", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 3, dateCreated: .now, isCompleted: false)
        ]
    // Index of the habit to modify
    @Published var habitToModifyIndex: Int = -1
    // Filters the habits based on the search query.
    func filterHabits(by searchHabit: String) -> [Habit] {
        guard !searchHabit.isEmpty else { return habitList }
        return habitList.filter { $0.name.localizedCaseInsensitiveContains(searchHabit) }
        }
    
    // filters the habits being searched in the Habit List
    
    /* switched to using swiftdata instead
     
    func deleteHabit(withUUID uuid: UUID) {
            if let index = habitList.firstIndex(where: { $0.id == uuid.uuidString }) {
                habitList.remove(at: index)
            }
        }
    
    func addHabit(_ habit: Habit) {
        habitList.append(habit)
    }
    
     */
    
    // Provides a priority rating emoji based on the priority level.
    func priorityRating(for priority: Int) -> String {
        switch priority {
        case 1:
            return "🐝"
        case 2:
            return "🐝🐝"
        default:
            return "🐝🐝🐝"
        }
    }
    
    
}

