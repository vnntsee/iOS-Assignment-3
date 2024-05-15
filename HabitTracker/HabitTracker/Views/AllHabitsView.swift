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
    @State private var color: Color = .earthYellow
    @State private var date = Date.now
    @State private var days: [Date] = []
    @State private var selectedMonth = Date.now.monthInt
    let weekdays = Date.weekdays
    let months = Date.months
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @Query private var habits: [Habit]
    @Query(sort: \Habit.name) private var habit: [Habit]
    @State private var selectedHabit: Habit?
    @ObservedObject var allHabitsVM = AllHabitsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor(named: "PastelYellowBackground") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all)
                VStack {
                    editAndAddButtons
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
                    }
                    .padding()
//                    }.toolbar {
//                        NavigationLink {
//                            AddHabitsView()
//                        } label: {
//                            Image(systemName: "plus.circle.fill")
//                                .foregroundStyle(.mediumYellow)
//                        }
//                        NavigationLink {
//                            EditHabitsView()
//                        } label: {
//                            Image(systemName: "list.bullet.circle.fill")
//                                .foregroundStyle(.mediumYellow)
//                        }
//                    }
                    VStack {
                        HStack {
                            Picker("", selection: $selectedMonth) {
                                ForEach(months.indices, id: \.self) { index in
                                    Text(months[index])
                                        .tag(index + 1)
                                        .font(.largeTitle)
                                }
                            }
                        }
                        VStack {
                            Text(months[selectedMonth - 1])
                                .font(.title)
                                .fontWeight(.bold)
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
                                        .frame(maxWidth: .infinity, minHeight: 70)
                                        .background {
                                            NavigationLink {
                                                TodayView()
                                            } label: {
                                                Hexagon()
                                                    .foregroundStyle(color)
                                                    .shadow(radius: 2)
                                            }
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
    
    var editAndAddButtons: some View {
        HStack {
            Spacer()
            NavigationLink {
                AddHabitsView()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundStyle(.mediumYellow)
            }
            NavigationLink {
                EditHabitsView()
            } label: {
                Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundStyle(.mediumYellow)
            }
        }
        .padding()
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
