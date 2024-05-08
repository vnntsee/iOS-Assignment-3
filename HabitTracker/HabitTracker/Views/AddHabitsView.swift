//
//  AddHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 8/5/2024.
//

import SwiftUI

struct AddHabitsView: View {
    
    @State var newHabitName = ""
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Add New Habit")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                    .padding()
                
                TextField("Enter Habit...", text: $newHabitName)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .padding()
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Add Habit")
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .foregroundColor(.black)
                        .background(Color.earthYellow)
                        .font(.title2)
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .padding()
                })
            }
        }
    }
}

#Preview {
    AddHabitsView()
}
