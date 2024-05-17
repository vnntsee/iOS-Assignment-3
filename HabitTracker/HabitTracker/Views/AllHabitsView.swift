//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Vannesa The on 7/5/2024.
//

import SwiftUI
import HexGrid
import SwiftData

struct AllHabitsView: View {
    @State private var date = Date.now // Current date
    @State private var days: [Date] = [] // Array of dates to display in the calendar
    @State private var selectedMonth = Date.now.monthInt // Selected month (initially set to the current month)
    let weekdays = Date.weekdays // Weekday names
    let months = Date.months // Month names
    let columns = Array(repeating: GridItem(.flexible()), count: 7) // Grid layout for the calendar
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color with pastel yellow
                Color(UIColor(named: "PastelYellowBackground") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all) // Ensures the color covers the entire screen
                VStack {
                    editAndAddButtons // Top right buttons for adding and editing habits act like a toolbar
                    title // Title page
                    monthPicker // Picker for selecting the month
                    monthText // Display selected month name
                    daysOfWeek // Days of the week headers
                    
                    // Grid layout for displaying days
                    LazyVGrid(columns: columns) {
                        ForEach(days, id: \.self) {day in
                            if day.monthInt != date.monthInt {
                                Text("") // Empty text for days not in the current month
                            } else {
                                // Display day number
                                Text(day.formatted(.dateTime.day()))
                                    .frame(maxWidth: .infinity, minHeight: 65)
                                    .background {
                                        // Each day (hexagon) will navigate to that specific date (today's) habit
                                        NavigationLink {
                                            TodayView()
                                        } label: {
                                            // Hexagon shape for the background
                                            Hexagon()
                                                .foregroundStyle(.earthYellow)
                                                .shadow(radius: 2)
                                        }
                                    }
                            }
                        }
                    }
                    // Pushes content to the top
                    Spacer()
                        .onAppear {
                            // Set initial days for the calendar
                            days = date.calendarDisplayDays
                        }
                        // Update days when date changes
                        .onChange(of: date) {
                            days = date.calendarDisplayDays
                        }
                        // Update date when selected month changes
                        .onChange (of: selectedMonth) {
                            updateDate()
                        }
                }
                // Padding around the VStack
                .padding()
            }
        }
    }
    
    // Updates the date based on the selected month
    func updateDate() {
        // Calculate the first day of the selected month in the year 2024
        date = Calendar.current.date(from: DateComponents(year: 2024, month: selectedMonth, day: 1))!
    }
    
    // Top right buttons for adding and editing habits
    var editAndAddButtons: some View {
        HStack {
            // Pushes buttons to the right
            Spacer()
            // Navigate to AddHabitsView
            NavigationLink {
                AddHabitsView()
            } label: {
                // Add habit button
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .frame(height: 5)
                    .foregroundStyle(.mediumYellow)
            }
            // Navigate to EditHabitsView
            NavigationLink {
                EditHabitsView()
            } label: {
                // Edit habits button
                Image(systemName: "list.bullet.circle.fill")
                    .font(.largeTitle)
                    .frame(height: 5)
                    .foregroundStyle(.mediumYellow)
            }
        }
        .padding()
    }
    
    // Title page with the text All Habits
    var title: some View {
        HStack {
            Text("All Habits")
                .font(.largeTitle)
                .fontWeight(.black)
            // Pushes content to the left
            Spacer()
        }
    }
    
    // Picker for selecting the month
    var monthPicker: some View {
        VStack {
            Picker("", selection: $selectedMonth) {
                // Iterates over the indices of the months array
                // Displays each month as a selectable item in the picker
                ForEach(months.indices, id: \.self) { index in
                    Text(months[index])
                        .font(.largeTitle)
                        .tag(index + 1)
                }
            }
        }
    }
    
    // Display selected month name
    var monthText: some View {
        VStack {
            Text(months[selectedMonth - 1])
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    // Days of the week
    var daysOfWeek: some View {
        HStack {
            // Iterates over the array of weekdays
            // Displays each weekday name
            ForEach(weekdays, id: \.self) { weekday in
                Text(weekday)
                // Makes each Text view take up as much horizontal space as possible
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        // Configuration for in-memory storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // Creating a model container
        let container = try ModelContainer(for: User.self, configurations: config)
        // Attaches the model container to the view
        return AllHabitsView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
