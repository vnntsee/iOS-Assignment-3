//
//  EditHabitsViewModel.swift
//  HabitTracker
//
//  Created by Katelyn Nguyen on 6/5/2024.
//

import Foundation

class EditHabitsViewModel: ObservableObject {
    
    @Published var habitList = []
    
    @Published var habitName: String
    
    init(habitName: String) {
        self.habitName = habitName
    }
}
