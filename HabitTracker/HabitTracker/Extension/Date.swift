//
//  Date.swift
//  HabitTracker
//
//  Created by Vannesa The on 12/5/2024.
//

import Foundation

extension Date {
    // Define a static variable to hold the first day of the week according to the calendar.
    static var firstDayOfWeek = Calendar.current.firstWeekday
    // Define a weekdays property to return an array of weekday names.
    static var weekdays: [String] {
        let calendar = Calendar.current // initialized with the current calendar instance
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
    
    // Define a months property to return an array of month names.
    static var months: [String] {
        // Create a date formatter to format dates.
        let dateFormatter = DateFormatter()
        // Set the locale of the date formatter to the current locale.
        dateFormatter.locale = Locale.current
        // Use compactMap to generate an array of month names.
        return (1...12).compactMap { month in
            // Set the date format to the full month name (e.g., "January").
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            // Create a date representing the first day of the specified month in the year 2024.
            let date = Calendar.current.date(from: DateComponents(year: 2024, month: month, day: 1))
            // Format the date to get the month name and return it.
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    
    // Calculate the start of the current month.
    var startOfMonth: Date {
        // Use Calendar's method to get the start date of the month interval for the current date.
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    // Calculate the end of the current month.
    var endOfMonth: Date {
        // Get the end date of the month interval for the current date.
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        // Subtract one day from the end date to get the last day of the current month.
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    // Calculate the start of the previous month.
    var startOfPreviousMonth: Date {
        // Calculate the date by subtracting one month from the current date.
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        // Get the start date of the month interval for the calculated date, which represents the start of the previous month.
        return dayInPreviousMonth.startOfMonth
    }
    
    // Calculate the number of days in the current month.
    var numberOfDaysInMonth: Int {
        // Get the day component from the end of the current month, which represents the total number of days in the month.
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    // Calculate the first day of the week before the start of the current month.
    var firstWeekDayBeforeStart: Date {
        // Get the weekday component of the start of the current month.
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        // Calculate the difference between the start of the current month's weekday and the configured first day of the week.
        var numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
        // If the result is negative, adjust it to be in the range of 0-6 (Sunday to Saturday).
        if numberFromPreviousMonth < 0 {
            numberFromPreviousMonth += 7
        }
        // Subtract the calculated number of days from the start of the current month to get the first day of the week before it.
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    // Generate an array of dates for displaying on a calendar grid.
    var calendarDisplayDays: [Date] {
        // Initialize an empty array to store the dates for display on the calendar grid.
       var days: [Date] = []
       // Start with days from the previous month to fill the grid
       let firstDisplayDay = firstWeekDayBeforeStart
       var day = firstDisplayDay
        // Iterate until the start of the current month is reached
       while day < startOfMonth {
           days.append(day) // Add the current day to the array
           day = Calendar.current.date(byAdding: .day, value: 1, to: day)! // Move to the next day
       }
       // Add days of the current month
        // Iterate through each day of the current month
       for dayOffset in 0..<numberOfDaysInMonth {
           // Calculate the date for the current day of the month
           let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
           days.append(newDay!) // Add the current day to the array
       }
       return days // Return the array of dates for display
    }
    
    // Extract the month component as an integer.
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    // Extract the year component as an integer.
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }
    
    // Extract the day component as an integer.
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    // Calculate the start of the current day.
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
