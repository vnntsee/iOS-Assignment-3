//
//  AddHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 8/5/2024.
//

import SwiftUI
import SwiftData

struct AddHabitsView: View {
    // Query property used to access all user records in the database
    @Query var users: [User]
    // Environment property for accessing the model context
    @Environment(\.modelContext) var modelContext
    // ObservedObject for managing users' habits
    @ObservedObject var usersVM = UsersViewModel()
    // ObservedObject for managing editing habits
    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    // StateObject for managing adding habits
    @StateObject var addHabitsVM = AddHabitsViewModel()
    // State variables for tracking new habit details
    @State var newHabitName = ""
    @State var newPriority: Int = 2
    @State private var daysSelected = Set<String>()
    // State variables for displaying alerts
    @State var habitAddedAlert: Bool = false
    @State private var showingAlert = false // Tracks whether to show an alert.
    @State private var alertMessage = "" // Stores the message to display in the alert.
    // Array of weekdays
    let weekdays = Date.weekdays
    
    var body: some View {
        ZStack {
            // Background color with light yellow
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all) // Ensures the color covers the entire screen

            VStack {
                // Title of the add new habit section
                Text("Add New Habit")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                    .padding(20)
                
                // Section for entering habit name
                Text("Enter the name of your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // TextField for entering habit name
                TextField("e.g. drink water once every hour.", text: $newHabitName)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                // Section for selecting habit priority
                Text("Select your habit's priority:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                // Picker for selecting habit priority
                // 1 = low, 2 = Medium, 3 = high
                Picker(selection: $newPriority, label: Text("Picker")) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom)
                
                // Section for selecting habit frequency
                Text("Select how often you want to complete your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                // List of buttons for selecting days
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
                .frame(maxWidth: 200, maxHeight: 200)
                .listStyle(.plain)
                .cornerRadius(20)
                .padding()
                .fontDesign(.monospaced)
                
                /* old code used for presentation.
                 { day in
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
                
                // Button for adding habit
                Button(action: {
                    addHabitsVM.habitName = newHabitName
                    addHabitsVM.daysSelected = daysSelected.joined(separator: ",")
                    addHabitsVM.validateInputs()
                    if let errorMessage = addHabitsVM.errorMessage {
                        showingAlert = true
                        alertMessage = errorMessage
                        habitAddedAlert = false
                    } else {
                        addHabit()
                        showingAlert = true
                        habitAddedAlert = true
                    }
                }, label: {
                    Text("Add Habit")
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .foregroundColor(.black)
                        .background(Color.earthYellow)
                        .font(.title2)
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .padding()
                })
                .alert(isPresented: $showingAlert) {
                    if habitAddedAlert {
                        Alert(title: Text("Habit Added"), message: Text("The habit has been successfully added."), dismissButton: .default(Text("OK!")))
                    } else {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
    
    // Function to add a habit
    func addHabit() {
        let newHabit = Habit(name: newHabitName, daysToComplete: Array(daysSelected), priority: newPriority, dateCreated: .now, isCompleted: false)
        
        //editHabitsVM.addHabit(newHabit)
        //modelContext.insert(newHabit)
        
        // Add new habit to user's list of habits
        usersVM.getUser(users: users).habits.append(newHabit)
        
        // Clear input fields and selections
        daysSelected = []
        newHabitName = ""
        newPriority = 2
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
        return AddHabitsView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
