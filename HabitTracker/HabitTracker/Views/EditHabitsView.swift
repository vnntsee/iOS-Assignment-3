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
    
    @State private var searchHabit:String = ""
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                Text("Habits")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                
                TextField("Search...", text: $searchHabit)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.regularMaterial)
                    .cornerRadius(30)
                
                List {
                    ForEach(editHabitsVM.filterHabits(by: searchHabit)) { habit in
                        VStack(alignment: .leading) {
                            Text("**\(habit.name)** \n")
                                .font(.system(size: 25))
                                .foregroundColor(.earthYellow)
                            
                            Text("**Priority:** \(habit.priority)\n")
                            
                            Text("**Days to Complete:**")
                                .foregroundColor(.mediumYellow)
                            
                            Text("\(habit.daysToComplete.joined(separator: ", "))")
                        }
                        .padding()
                        // where all the buttons for editing the list is located.
                        .contextMenu(ContextMenu(menuItems: {
                            
                            /*Button(action: editHabitsVM.editPressed = true)*/
                            Text("Edit")
                            
                            // deletes the habit
                            Button(action: {
                                withAnimation {
                                    editHabitsVM.deleteHabit(withUUID: UUID(uuidString: habit.id)!)
                                }
                            }) {
                                Text("Delete")
                            }
                            
                            Text("Menu Item 3")
                        }))
                    }
                }
                // edits the look of the list
                .font(.system(size: 20))
                .fontDesign(.monospaced)
                .listRowBackground(Color.white)
                .listStyle(.plain)
                .cornerRadius(30)
                
                .sheet(isPresented: $editHabitsVM.editPressed) {
                    AddHabitsView()
                }
            }
            .padding()
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
