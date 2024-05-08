//
//  EditHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import SwiftUI

struct EditHabitsView: View {
    
    @State var habitList: [Habit] = [Habit(name: "Exercise for 30 mins", daysToComplete: [5,6], priority: 2), Habit(name: "Study for 2 hours", daysToComplete: [0,2], priority: 1), Habit(name: "Eat 3 fruits", daysToComplete: [0,1,2,3,4,5,6], priority: 2), Habit(name: "Practice French", daysToComplete: [0,1,2,3,4,5,6], priority: 3)]
    
    @State private var habitName:String = ""
    
    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                Text("Habits")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                
                TextField("Search...", text: $habitName)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.regularMaterial)
                    .cornerRadius(30)
                
                List {
                    ForEach(habitList, id: \.self) { habit in
                        Text(habit.name)
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
    EditHabitsView()
}
