//
//  TodayView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 3/5/2024.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    
    //DELETE
    @State var sampleHabits: [Habit] = [Habit(name: "Exercise for 30 mins", daysToComplete: [5,6], priority: 2), Habit(name: "Study for 2 hours", daysToComplete: [0,2], priority: 1), Habit(name: "Eat 3 fruits", daysToComplete: [0,1,2,3,4,5,6], priority: 2), Habit(name: "Practice French", daysToComplete: [0,1,2,3,4,5,6], priority: 3)]
    
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                todayTitle
                Spacer()
                progressBox
                habitsListTitle
                ScrollView {
                    habitsList
                        .padding(.vertical)
                }
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
        }
    }
    
    var todayTitle: some View {
        Text("Today's Habits")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
    
    var progressBox: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(width: 200, height: 150)
            .shadow(radius: 10)
            .padding()
    }
    
    var habitBox: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 50, height: 50)
            .shadow(radius: 7)
    }
    
    var habitsListTitle: some View {
        HStack {
            Text("Status")
            Spacer()
            Text("Habit")
            Spacer()
            Text("Priority")
        }
        .font(.title3)
        .fontWeight(.bold)
        .padding(.horizontal)
    }
    
    var habitsList: some View {
        ForEach(sampleHabits, id: \.id) { habit in
            HStack {
                habitBox
                    .foregroundColor(habit.isCompleted ? .green : .white) //view isn't updated
                    .onTapGesture {
                        habit.isCompleted.toggle()
                        print("\(habit.name) completion status: \(habit.isCompleted)")
                    }
                    .padding(.horizontal)
                Text(habit.name)
                    .padding(.horizontal, 15)
                Spacer()
                Text("\(habit.priority)")
                    .padding(.horizontal, 45)
                    .fontWeight(.bold)
            }
        }
    }
    
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return TodayView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
