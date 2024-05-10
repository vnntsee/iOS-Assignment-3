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
    
    @State private var daysSelected: Set<String> = []
    
    @State var habitAddedAlert: Bool = false
    
    let days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
    
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
                
                List(days, id: \.self) { day in
                    Button(action: {
                        if daysSelected.contains(day) {
                            daysSelected.remove(day)
                        } else {
                            daysSelected.insert(day)
                        }
                    }) {
                        HStack {
                            Text(day)
                            Spacer()
                            if daysSelected.contains(day) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.orange)
                                    .bold()
                            }
                        }
                    }
                }
                .frame(maxWidth: 200, maxHeight: 200)
                .listStyle(.plain)
                .cornerRadius(20)
                .padding(.horizontal)
                .fontDesign(.monospaced)
                
                
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
                
                .alert(isPresented: $habitAddedAlert) {
                            Alert(title: Text("Habit Added"), message: Text("The habit has been successfully added."), dismissButton: .default(Text("OK!")))
                        }
                
            }
        }
    }
    func addHabit() {
            let newHabit = Habit(name: newHabitName, daysToComplete: Array(daysSelected), priority: newPriority, dateCreated: .now, isCompleted: false)
        
        editHabitsVM.addHabit(newHabit)
                
        daysSelected = []
        newHabitName = ""
        newPriority = 2
        
        // show habit added alert
        habitAddedAlert = true
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
