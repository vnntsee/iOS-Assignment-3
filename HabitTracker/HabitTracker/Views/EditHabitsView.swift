//
//  EditHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import SwiftUI

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
