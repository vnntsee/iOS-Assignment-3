//
//  EditHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import SwiftUI

struct EditHabitsView: View {
    @State private var habitList = ["HabitExample1", "HabitExample2 looooong example", "HabitExample3"]
    
    @State private var newHabit = ""
    
    var body: some View {
        ZStack {
            /*
            Color.yellow
                .ignoresSafeArea()
            */
            VStack {
                Text("Habits")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                
                List {
                    ForEach(habitList, id: \.self) { habit in
                        Text(habit)
                            .padding()
                    }
                }
                .font(.system(size: 20))
                .fontDesign(.monospaced)
                .foregroundColor(.brown)
            }
            .padding()
        }
    }
}

#Preview {
    EditHabitsView()
}
