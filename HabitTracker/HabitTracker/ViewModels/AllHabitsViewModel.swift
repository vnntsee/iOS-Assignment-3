//
//  AllHabitsViewModel.swift
//  HabitTracker
//
//  Created by Vannesa The on 8/5/2024.
//

import Foundation
import SwiftUI
import HexGrid

struct HexCell: Identifiable, OffsetCoordinateProviding {
    var id: Int { offsetCoordinate.hashValue }
    var offsetCoordinate: OffsetCoordinate
    var completionStatus: Bool
}

class AllHabitsViewModel: ObservableObject {
    
    func generateCellsForMonth(year: Int, month: Int) -> [HexCell] {
        // Determine the number of weeks in a month
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1)) else {
            return []
        }
        
        let range = calendar.range(of: .weekOfMonth, in: .month, for: firstDayOfMonth)!
        let numberOfWeeksInMonth = range.count
        // Create cells for each week
        var cells: [HexCell] = []
        let habits = getHabitsForMonth(year: year, month: month)
        for week in 0..<numberOfWeeksInMonth {
            for day in 0..<7 {
                guard let currentDate = calendar.date(byAdding: .day, value: (week * 7) + day, to: firstDayOfMonth) else {
                    continue
                }
                let completionStatus = habits.contains { habit in
                    let habitWeekday = Calendar.current.component(.weekday, from: habit.dateCreated)
                    return habitWeekday == calendar.component(.weekday, from: currentDate)
                }
                // Populate cells array with HexCell instances for each week
                cells.append(HexCell(offsetCoordinate: .init(row: week, col: day), completionStatus: completionStatus))
            }
        }
        return cells
    }
    
    private func getHabitsForMonth(year: Int, month: Int) -> [Habit] {
        let sampleHabits = [
//            Habit(name: "Exercise", daysToComplete: [1, 3, 5], priority: 1, dateCreated: Date(), isCompleted: true),
//            Habit(name: "Read", daysToComplete: [2, 4, 6], priority: 2, dateCreated: Date(), isCompleted: false)
            Habit(name: "Exercise", daysToComplete: ["Mon", "Tue", "Wed"], priority: 1, dateCreated: Date(), isCompleted: true),
            Habit(name: "Read", daysToComplete: ["Tue", "Thu", "Sat"], priority: 2, dateCreated: Date(), isCompleted: false)
        ]
        return sampleHabits
    }
}
