//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 7/5/2024.
//

import SwiftUI

struct AddHabitView: View {
    
    @State var newHabitName = ""
    
    var body: some View {
            ZStack {
                Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                    .ignoresSafeArea(.all)
                
                VStack {
                    Text("Add Habit")
                        .font(.largeTitle)
                        .padding()
                        .bold()
                        .foregroundColor(.brown)
                    
                    TextField("Enter Habit Name", text: $newHabitName)
                        .padding()
                        .frame(width: .infinity, height: 55)
                        .background(.pastelYellow)
                        .cornerRadius(15)
                        .padding()
                        
                    Spacer()
                }
            }
    }
}

#Preview {
    AddHabitView()
}
