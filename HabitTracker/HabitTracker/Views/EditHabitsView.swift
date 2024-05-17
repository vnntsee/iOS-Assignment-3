//
//  EditHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import SwiftUI
import SwiftData

struct EditHabitsView: View {
    // View model for editing habits
    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    // View model for users
    @ObservedObject var usersVM = UsersViewModel()
//    @Query(filter: #Predicate<User> { user in
//        user.name == "Tester"}) var currentUser: [User]
    // Query to fetch users
    @Query var users: [User]
//    @Query var habits: [Habit]
    // Environment property to access the model context
    @Environment(\.modelContext) var modelContext
    // State variable to control navigation to ModifyHabitView
    @State var goToEdit = false
    // State variable for search text in the search bar
    @State private var searchHabit:String = ""
    
    var body: some View {
//        NavigationStack {
            ZStack {
                // Background color with light yellow
                Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all) // Ensures the color covers the entire screen
                VStack {
                    ZStack {
                        homeButton
                        Text("Habits")
                            .font(.largeTitle)
                            .foregroundStyle(.orange)
                            .bold()
                    }
                    // Filters the habits the user wants to look for.
                    TextField("Search...", text: $searchHabit)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.regularMaterial)
                        .cornerRadius(30)
                    
                    // lists the habits the user has made and filters it by what the user has typed in the search bar
                    List {
                        ForEach(usersVM.getUser(users: users).habits.sorted(by: {$0.dateCreated < $1.dateCreated}).indices, id: \.self) { index in
                            let habit = usersVM.getUser(users: users).habits[index]
                            VStack(alignment: .leading) {
                                Text("**\(habit.name)**")
                                    .foregroundColor(.earthYellow)
                                    .bold()
                                    .font(.system(size: 25))
                                
                                Text("**Priority:** \(habit.priority)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 2)
                                
                                Text("**Days to Complete:**")
                                    .foregroundColor(.mediumYellow)
                                
                                Text("\(habit.daysToComplete.joined(separator: ", "))")
                            }
                            .onTapGesture {
                                // Navigate to ModifyHabitView when tapping on a habit
                                editHabitsVM.habitToModifyIndex = index
                                goToEdit = true
                            }
                        }
                        .navigationDestination(isPresented: $goToEdit, destination: {
                            ModifyHabitView(editHabitsVM: editHabitsVM)
                        })
                    }
                    //edits the look of the list
                    .navigationBarBackButtonHidden(true)
                    .font(.system(size: 20))
                    .fontDesign(.monospaced)
                    .listRowBackground(Color.white)
                    .listStyle(.plain)
                    .cornerRadius(30)

                    
                    
//                    Code below used MVVM for the presentation.
//                    List {
//                        ForEach(editHabitsVM.filterHabits(by: searchHabit)) { habit in NavigationLink(destination: ModifyHabitView(editHabitsVM: editHabitsVM)) {
//                            VStack(alignment: .leading) {
//                                Text("**\(habit.name)**")
//                                    .foregroundColor(.earthYellow)
//                                    .bold()
//                                    .font(.system(size: 25))
//                                
//                                Text("**Priority:** \(habit.priority)")
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.vertical, 2)
//                                
//                                Text("**Days to Complete:**")
//                                    .foregroundColor(.mediumYellow)
//                                
//                                Text("\(habit.daysToComplete.joined(separator: ", "))")
//                            }
//                        }
//                        }
//                        
//                        .padding()
//                    }
//                    // edits the look of the list
//                    .font(.system(size: 20))
//                    .fontDesign(.monospaced)
//                    .listRowBackground(Color.white)
//                    .listStyle(.plain)
//                    .cornerRadius(30)
//                    
//                    .sheet(isPresented: $editHabitsVM.editPressed) {
//                        ModifyHabitView()
//                    }
                }
                .padding()
            }
        }
    
    // Home Button
    var homeButton: some View {
        HStack {
            Spacer()
            // Navigate to Tab Bar View when clicking the home button
            NavigationLink {
                TabBarView()
            } label: {
                Image(systemName: "house.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundStyle(.earthYellow)
            }
        }
    }
//    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        // Configuration for in-memory storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // Creating a model container
        let container = try ModelContainer(for: User.self, configurations: config)
        // Attaches the model container to the view
        return EditHabitsView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
