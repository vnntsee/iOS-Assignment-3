//
//  EditHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import SwiftUI

struct EditHabitsView: View {
    @State private var habitList = ["Drink water.", "Go to exercise at the gym.", "Read a book.", "Work on assignments."]
    
    @State private var habitName:String = ""
    
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
                        Text(habit)
                            .padding()
                    }
                }
                .font(.system(size: 20))
                .fontDesign(.monospaced)
                .foregroundColor(.brown)
                .listRowBackground(Color.clear)
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
