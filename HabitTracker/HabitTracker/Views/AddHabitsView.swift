//
//  AddHabitsView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 8/5/2024.
//

import SwiftUI
import SwiftData

struct AddHabitsView: View {
    
    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    
    @State var newHabitName = ""
    
    @State var newPriority: Int = 2
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Add New Habit")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                    .padding(20)
                
                Text("Enter the name of your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                // where the user enters the name of the habit they want to add
                TextField("e.g. drink water once every hour.", text: $newHabitName)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                Text("Select your habit's priority:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                
                // a picker that allows the user to choose the habit's priority level, 1 = low, 3 = high
                Picker(selection: $newPriority, label: Text("Picker")) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom)
                
                Text("Select how often you want to complete your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                
                
                Spacer()
                Button(action: addHabit, label: {
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
    func addHabit() {
            let newHabit = Habit(name: newHabitName, priority: newPriority)
            editHabitsVM.addHabit(newHabit)
        }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return AddHabitsView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
