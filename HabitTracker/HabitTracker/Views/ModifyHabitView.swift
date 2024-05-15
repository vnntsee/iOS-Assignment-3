//
//  ModifyHabitView.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 13/5/2024.
//

import SwiftUI
import SwiftData

struct ModifyHabitView: View {
    @ObservedObject var editHabitsVM = EditHabitsViewModel()
    
    @Query var habits: [Habit]
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedHabit: Habit?
    
    @State var newHabitName = ""
    
    @State var newPriority: Int = 2
    
    @State private var daysSelected = Set<String>()

    @State var habitUpdatedAlert: Bool = false
    
    let weekdays = Date.weekdays
    
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Edit Habit")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                    .bold()
                    .padding(20)
                
                Text("Update the name of your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // where the user enters the name of the habit they want to add
                TextField("", text: $newHabitName)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                Text("Update your habit's priority:")
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
                
                Text("Update how often you want to do your habit:")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                List {
                    ForEach(weekdays, id: \.self) { weekday in
                        Button(action: {
                            if daysSelected.contains(weekday) {
                                daysSelected.remove(weekday)
                            } else {
                                daysSelected.insert(weekday)
                            }
                        }) {
                            HStack {
                                Text(weekday)
                                Spacer()
                                if daysSelected.contains(weekday) {
                                    Image(systemName: "hexagon.fill")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: 200, maxHeight: 200)
                .listStyle(.plain)
                .cornerRadius(20)
                .padding()
                .fontDesign(.monospaced)
                
                /*
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
                                Image(systemName: "hexagon.fill")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                        }
                    }
                }
                
                */
                
                Spacer()
                
                Button(action: editHabit, label: {
                    Text("Update Habit")
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .foregroundColor(.black)
                        .background(Color.earthYellow)
                        .font(.title2)
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .padding()
                })
                
                Button(action: deleteHabit, label: {
                        Text("Delete Habit")
                        .foregroundColor(.red)
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    })
                
                .alert(isPresented: $habitUpdatedAlert) {
                    Alert(title: Text("Habit Updated"), message: Text("The habit has been successfully updated."), dismissButton: .default(Text("OK!")))
                }
            }
        }
    }
    func editHabit() {
        let modifiedHabit = Habit(name: newHabitName, daysToComplete: Array(daysSelected), priority: newPriority, dateCreated: .now, isCompleted: false)
        
        // show habit updated alert
        habitUpdatedAlert = true
    }
    
    func deleteHabit() {
        
    }
    
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return ModifyHabitView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
