//
//  ModifyHabitView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 13/5/2024.
//

import SwiftUI
import SwiftData

struct ModifyHabitView: View {
    // ObservedObject for managing editing habits
    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    // ObservedObject for managing users' habits
    @ObservedObject var usersVM = UsersViewModel()
    // Query property used to access all user records in the database
    @Query var users: [User]
    // Environment property for accessing the model context
    @Environment(\.modelContext) var modelContext
    // State variable for storing the selected habit to modify
    @State private var selectedHabit: Habit?
    // State variables for managing updated habit details
    @State var updatedHabitName = ""
    @State var newPriority: Int = 2
    @State private var daysSelected = Set<String>()
    // State variables for displaying alerts
    @State var habitUpdatedAlert: Bool = false
    @State var isDeleted: Bool = false
    // Array of weekdays
    let weekdays = Date.weekdays
    
    
    var body: some View {
        ZStack {
            // Background color with light yellow
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all) // Ensures the color covers the entire screen
            
            VStack {
                // Title of the edit habit section
                Text("Edit Habit")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                    .padding(20)
                // Section for updating habit name
                Text("Update the name of your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                // TextField for entering updated habit name
                TextField("\(getHabitName())", text: $updatedHabitName)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                // Section for updating habit priority
                Text("Update your habit's priority:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                // Picker for selecting updated habit priority
                // 1 = low, 2 = medium, 3 = high
                Picker(selection: $newPriority, label: Text("Picker")) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom)
                
                // Section for updating habit frequency
                Text("Update how often you want to do your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                // List of buttons for selecting updated days
                List {
                    ForEach(weekdays, id: \.self) { weekday in
                        Button(action: {
                            if daysSelected.contains(weekday) {
                                daysSelected.remove(weekday)
                            } else {
                                daysSelected.insert(weekday)
                            }
                        }) {
                            HStack {
                                Text(weekday)
                                Spacer()
                                if daysSelected.contains(weekday) {
                                    Image(systemName: "hexagon.fill")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                            }
                        }
                    }
                }
                .navigationDestination(isPresented: $habitUpdatedAlert, destination: {
                    EditHabitsView()
                })
                .frame(maxWidth: 200, maxHeight: 200)
                .listStyle(.plain)
                .cornerRadius(20)
                .padding()
                .fontDesign(.monospaced)
                
                /*
                List(days, id: \.self) { day in
                    Button(action: {
                        if daysSelected.contains(day) {
                            daysSelected.remove(day)
                        } else {
                            daysSelected.insert(day)
                        }
                    }) {
                        HStack {
                            Text(day)
                            Spacer()
                            if daysSelected.contains(day) {
                                Image(systemName: "hexagon.fill")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                        }
                    }
                }
                
                */
                
                Spacer()
                
                // Button for updating habit
                Button(action: editHabit, label: {
                    Text("Update Habit")
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .foregroundColor(.black)
                        .background(Color.earthYellow)
                        .font(.title2)
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .padding()
                })
                // Button for deleting habit
                Button(action: deleteHabit, label: {
                        Text("Delete Habit")
                        .foregroundColor(.red)
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    })
                // Display alert based on the state of the HabitUpdatedAlert
                .alert(isPresented: $habitUpdatedAlert) {
                    Alert(title: Text(isDeleted ? "Habit Deleted!" : "Habit Updated!"), message: Text(isDeleted ? "The habit has been deleted!" : "The habit has been successfully updated."), dismissButton: .default(Text("OK!")))
                }
            }
        }
    }
    
    // Function to check if the index of the habit to modify is valid
    func indexIsValid() -> Bool {
        if editHabitsVM.habitToModifyIndex >= 0 && editHabitsVM.habitToModifyIndex < usersVM.getUser(users: users).habits.count {
            return true
        }
        return false
    }
    // Function to edit habit
    func editHabit() {
        let modifiedHabit = Habit(name: updatedHabitName, daysToComplete: Array(daysSelected), priority: newPriority, isCompleted: false)
        
        guard indexIsValid() else {return}
        usersVM.getUser(users: users).habits[editHabitsVM.habitToModifyIndex] = modifiedHabit
        
        // show habit updated alert
        habitUpdatedAlert = true
    }
    
    // Function to delete habit
    func deleteHabit() {
        guard indexIsValid() else {return}
        
        usersVM.getUser(users: users).habits.remove(at: editHabitsVM.habitToModifyIndex)
        isDeleted = true
        habitUpdatedAlert = true
    }
    
    // Function to get the habit name
    func getHabitName() -> String {
        guard indexIsValid() else {return ""}
        return usersVM.getUser(users: users).habits[editHabitsVM.habitToModifyIndex].name
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
        return ModifyHabitView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
