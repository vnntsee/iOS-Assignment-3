//
//  TodayView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 3/5/2024.
//

import SwiftUI
import SwiftData
import HexGrid

struct TodayView: View {
    
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    
    //DELETE
    @State var sampleHabits: [Habit] = [Habit(name: "Exercise for 30 mins", daysToComplete: ["Fri","Sat"], priority: 2), Habit(name: "Study for 2 hours", daysToComplete: ["Mon","Tue"], priority: 1), Habit(name: "Eat 3 fruits", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 2), Habit(name: "Practice French", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 3)]
    
    @ObservedObject var habitsVM = TodayHabitsViewModel()
    @ObservedObject var usersVM = UsersViewModel()
  
    var body: some View {
        ZStack {
            // Background color with pastel yellow
            Color(UIColor(named: "PastelYellowBackground") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all) // Ensures the color covers the entire screen
            VStack {
                ZStack {
                    score
                    todayTitle
                }
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
        Hexagon()
            .fill(Color(UIColor(named: "MediumYellow") ?? UIColor(Color.yellow)))
            .frame(width: 350, height: 150)
            .shadow(radius: 5)
            .overlay {
                Hexagon()
                    .fill(Color.white)
                    .frame(width: 350, height: 150)
                    .opacity(habitsVM.completionOpacity)
            }
            .padding()
        
    }
    
    var habitBox: some View {
        Hexagon()
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
                        usersVM.getUser(users: users).points += habitsVM.pointsUpdateAmount(habit: habit)
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
    
    var score: some View {
        HStack {
            Spacer()
            ZStack {
                habitBox
                    .foregroundStyle(Color(UIColor(named: "MediumYellow") ?? UIColor(Color.yellow)))
                Text("\(usersVM.getUser(users: users).points)")
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
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
        //Adding Habit model to container isn't necessary since it's linked to User through @Relationship.
        
        // Attaches the model container to the view
        return TodayView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
