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
    // Query to fetch users
    @Query var users: [User]
    // Environment property to access the model context
    @Environment(\.modelContext) var modelContext
    
    // State variables to track habit completion
    @State var totalTodayHabits: Int = 4
    @State var numHabitsCompleted: Int = 0
    @State var completionOpacity: Double = 1
    
    // Sample habits data
    @State var sampleHabits: [Habit] = [Habit(name: "Exercise for 30 mins", daysToComplete: ["Fri","Sat"], priority: 2), Habit(name: "Study for 2 hours", daysToComplete: ["Mon","Tue"], priority: 1), Habit(name: "Eat 3 fruits", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 2), Habit(name: "Practice French", daysToComplete: ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"], priority: 3)]
    // Observed objects for view models
    @ObservedObject var habitsVM = TodayHabitsViewModel()
    @ObservedObject var usersVM = UsersViewModel()
    // State variable for points
    @State var points: Int = 0
    
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
    // Title for today's habits
    var todayTitle: some View {
        Text("Today's Habits")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
    
    // Progress box displaying completion status
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
    
    // Hexagon representing a habit
    var habitBox: some View {
        Hexagon()
            .frame(width: 50, height: 50)
            .shadow(radius: 5)
    }
    
    // Title for habits list
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
    
    // List of habits
    var habitsList: some View {
        ForEach(sampleHabits, id: \.id) { habit in
            HStack {
                habitBox
                    .foregroundColor(habit.isCompleted ? Color(UIColor(named: "MediumYellow") ?? UIColor(Color.yellow)) : .white)
                    .onTapGesture {
                        //Updates habit status and progress box colour based on it.
                        habit.isCompleted.toggle()
                        updateHabitsCompleted(habit: habit)
                        updateHabitsColour()
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
    
    // Score view
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
    
    // Update the opacity of progress box based on completed habits
    //Decreases opacity by the ratio of the number of habits completed to the total.
    func updateHabitsColour() {
        habitsVM.completionOpacity = 1 - (Double(habitsVM.numHabitsCompleted) / Double(habitsVM.totalTodayHabits))
    }

    // Update the number of completed habits
    func updateHabitsCompleted(habit: Habit) {
        if habit.isCompleted {
            habitsVM.numHabitsCompleted += 1
        }
        else {
            habitsVM.numHabitsCompleted -= 1
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
