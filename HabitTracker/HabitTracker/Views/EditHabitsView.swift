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
                        Text("\(habit.name) \nPriority: \(habit.priority) \n\nDays to Complete: \(habit.daysToComplete.joined(separator: ", "))")
                                .padding()
                    }
                }
                .font(.system(size: 20))
                .fontDesign(.monospaced)
                .foregroundColor(.brown)
                .listRowBackground(Color.white)
                .listStyle(.plain)
                .cornerRadius(30)
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
