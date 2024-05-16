//
//  EditHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import SwiftUI
import SwiftData

struct EditHabitsView: View {

    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    
    @ObservedObject var usersVM = UsersViewModel()
//    @Query(filter: #Predicate<User> { user in
//        user.name == "Tester"}) var currentUser: [User]
    @Query var users: [User]
    
    @Query var habits: [Habit]
    @Environment(\.modelContext) var modelContext
    
    @State private var searchHabit:String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all)
                VStack {
                    Text("Habits")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                        .bold()
                    // Filters the habits the user wants to look for.
                    TextField("Search...", text: $searchHabit)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.regularMaterial)
                        .cornerRadius(30)
                    
                    
                    
                    
                    List {
                        ForEach(usersVM.getUser(users: users).habits) { habit in
                            Text("\(habit.name)")
                        }
                    }
                    
                    
                    
                    List {
                        ForEach(editHabitsVM.filterHabits(by: searchHabit)) { habit in NavigationLink(destination: ModifyHabitView(editHabitsVM: editHabitsVM)) {
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
                        }
                        }
                        
                        .padding()
                    }
                    // edits the look of the list
                    .font(.system(size: 20))
                    .fontDesign(.monospaced)
                    .listRowBackground(Color.white)
                    .listStyle(.plain)
                    .cornerRadius(30)
                    
                    .sheet(isPresented: $editHabitsVM.editPressed) {
                        ModifyHabitView()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return EditHabitsView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
