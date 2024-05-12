//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Vannesa The on 7/5/2024.
//

import SwiftUI
import HexGrid
import SwiftData

struct HexCell: Identifiable, OffsetCoordinateProviding {
    var id: Int { offsetCoordinate.hashValue }
    var offsetCoordinate: OffsetCoordinate
    var colorName: Color
}

struct AllHabitsView: View {
    @State private var color: Color = .earthYellow
    @State private var date = Date.now
    @State private var days: [Date] = []
//    @State private var years: [Int] = []
    @State private var selectedMonth = Date.now.monthInt
//    @State private var selectedYear = Date.now.yearInt
    let weekdays = Date.weekdays
    let months = Date.months
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @Query private var habits: [Habit]
    @Query(sort: \Habit.name) private var habit: [Habit]
    @State private var selectedHabit: Habit?
    @StateObject var allHabitsVM = AllHabitsViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor(named: "PastelYellowBackground") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Text("All Habits")
                            .font(.largeTitle)
                            .fontWeight(.black)
                        Picker("", selection: $selectedHabit) {
                            Text("All").tag(nil as Habit?)
                            ForEach(habit) { habit in
                                Text(habit.name)
                                    .tag(habit as Habit?)
                            }
                        }
                        Spacer()
                    }.toolbar {
                        NavigationLink {
                            AddHabitsView()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.mediumYellow)
                        }
                        NavigationLink {
                            EditHabitsView()
                        } label: {
                            Image(systemName: "list.bullet.circle.fill")
                                .foregroundStyle(.mediumYellow)
                        }
                    }
                    .padding()
                    VStack {
                        HStack {
//                            Picker("", selection: $selectedYear) {
//                                ForEach(years, id: \.self) { year in
//                                    Text(String(year))
//                                }
//                            }
                            Picker("", selection: $selectedMonth) {
                                ForEach(months.indices, id: \.self) { index in
                                    Text(months[index])
                                        .tag(index + 1)
                                }
                            }
                        }
                        
                        HStack{
                            ForEach(weekdays, id: \.self) { weekday in
                                Text(weekday)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        LazyVGrid(columns: columns) {
                            ForEach(days, id: \.self) {day in
                                if day.monthInt != date.monthInt {
                                    Text("")
                                } else {
                                    Text(day.formatted(.dateTime.day()))
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background {
                                            Hexagon()
                                                .foregroundStyle(color)
                                                .shadow(radius: 2)
                                        }
                                }
                            }
                        }
                        .onAppear {
                            days = date.calendarDisplayDays
                        }
                        .onChange(of: date) {
                            days = date.calendarDisplayDays
                        }
                        .onChange (of: selectedMonth) {
                            updateDate()
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
    func updateDate() {
        date = Calendar.current.date(from: DateComponents(year: 2024, month: selectedMonth, day: 1))!
    }
    func hexagonColor(for habit: Habit) -> Color {
        return allHabitsVM.completedHabits.contains(habit) ? .earthYellow : .pastelYellow
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        return AllHabitsView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
