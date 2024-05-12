//
//  AllHabitsViewModel.swift
//  HabitTracker
//
//  Created by Vannesa The on 8/5/2024.
//

import Foundation
import SwiftUI
import HexGrid

class AllHabitsViewModel: ObservableObject {
    @Published var completedHabits: [Habit] = []
}

extension Date {
    // Define a static variable to hold the first day of the week according to the calendar.
    static var firstDayOfWeek = Calendar.current.firstWeekday
    // Define a weekdays property to return an array of weekday names.
    static var weekdays: [String] {
        let calendar = Calendar.current
        var weekdays = calendar.shortWeekdaySymbols // Get the abbreviated weekday symbols
        
        // If the first day of the week is not Sunday (which has a value of 1), adjust the array.
        if firstDayOfWeek > 1 {
            // Rotate the array to start from the configured first day of the week.
            for _ in 1..<firstDayOfWeek {
                if let first = weekdays.first {
                    weekdays.append(first)
                    weekdays.removeFirst()
                }
            }
        }
        // Return the array of weekday names.
        return weekdays
    }
    
    static var months: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    // New to accomodate for different start of week days
    var firstWeekDayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        // previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        
        // Fixed to accomodate different weekday starts
        return days.filter { $0 >= firstWeekDayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

//struct HexCell: Identifiable, OffsetCoordinateProviding {
//    var id: Int { offsetCoordinate.hashValue }
//    var offsetCoordinate: OffsetCoordinate
//    var completionStatus: Bool
//}
//
//class AllHabitsViewModel: ObservableObject {
//
//    func generateCellsForMonth(year: Int, month: Int) -> [HexCell] {
//        // Determine the number of weeks in a month
//        let calendar = Calendar.current
//        guard let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1)) else {
//            return []
//        }
//
//        let range = calendar.range(of: .weekOfMonth, in: .month, for: firstDayOfMonth)!
//        let numberOfWeeksInMonth = range.count
//        // Create cells for each week
//        var cells: [HexCell] = []
//        let habits = getHabitsForMonth(year: year, month: month)
//        for week in 0..<numberOfWeeksInMonth {
//            for day in 0..<7 {
//                guard let currentDate = calendar.date(byAdding: .day, value: (week * 7) + day, to: firstDayOfMonth) else {
//                    continue
//                }
//                let completionStatus = habits.contains { habit in
//                    let habitWeekday = Calendar.current.component(.weekday, from: habit.dateCreated)
//                    return habitWeekday == calendar.component(.weekday, from: currentDate)
//                }
//                // Populate cells array with HexCell instances for each week
//                cells.append(HexCell(offsetCoordinate: .init(row: week, col: day), completionStatus: completionStatus))
//            }
//        }
//        return cells
//    }
//
//    private func getHabitsForMonth(year: Int, month: Int) -> [Habit] {
//        let sampleHabits = [
//            Habit(name: "Exercise", daysToComplete: ["Tue", "Wed", "Sat"], priority: 1, dateCreated: Date(), isCompleted: true),
//            Habit(name: "Read", daysToComplete: ["Tue", "Monday", "Sun"], priority: 2, dateCreated: Date(), isCompleted: false)
//        ]
//        return sampleHabits
//    }
//}
