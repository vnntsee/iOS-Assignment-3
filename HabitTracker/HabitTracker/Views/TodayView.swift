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
    @State var sampleHabits: [Habit] = [Habit(name: "Exercise for 30 mins", daysToComplete: ["Fri","Sat"], priority: 2), Habit(name: "Study for 2 hours", daysToComplete: ["Mon","Tue"], priority: 1), Habit(name: "Eat 3 fruits", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 2), Habit(name: "Practice French", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 3)]
    
    @ObservedObject var habitsVM = TodayHabitsViewModel()
    @ObservedObject var usersVM = UsersViewModel()
  
    var body: some View {
        ZStack {
            Color(UIColor(named: "PastelYellowBackground") ?? UIColor(Color.yellow.opacity(0.4)))
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
        //First rectangle displays colour for all habits having been completed. Second rectangle is white with a starting opacity of 1 which is decreased as habits are completed.
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(UIColor(named: "MediumYellow") ?? UIColor(Color.yellow)))
            .frame(width: 200, height: 150)
            .shadow(radius: 5)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .frame(width: 200, height: 150)
                    .opacity(habitsVM.completionOpacity)
            }
            .padding()
        
    }
    
    var habitBox: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 50, height: 50)
            .shadow(radius: 5)
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
        .padding()
        .background(Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4))))
    }
    
    var habitsList: some View {
        ForEach(sampleHabits, id: \.id) { habit in
            HStack {
                habitBox
                    .foregroundColor(habit.isCompleted ? Color(UIColor(named: "MediumYellow") ?? UIColor(Color.yellow)) : .white)
                    .onTapGesture {
                        //Updates habit status and progress box colour based on it.
                        habit.isCompleted.toggle()
                        habitsVM.updateHabitsCompleted(habit: habit)
                        habitsVM.updateHabitsColour()
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
        //Adding Habit model to container isn't necessary since it's linked to User through @Relationship.
        
        return TodayView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
