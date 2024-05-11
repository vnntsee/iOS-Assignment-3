//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Vannesa The on 7/5/2024.
//

import SwiftUI
import HexGrid
import SwiftData

struct AllHabitsView: View {
    @ObservedObject var allHabitsViewModel = AllHabitsViewModel()
    let currentMonth = Calendar.current.component(.month, from: Date())
    let currentYear = Calendar.current.component(.year, from: Date())
    let monthSymbols = Calendar.current.monthSymbols
    let weekdaySymbols = Calendar.current.shortWeekdaySymbols
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("All Habits")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Spacer()
                    NavigationLink {
                        EditHabitsView()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.black)
                    }
                    
                }
                .padding()
                Spacer()
                
                Text("May")
                    .font(.title)
                    .fontWeight(.black)
                HStack{
                    Text("Mon")
                        .padding(.horizontal, 7)
                    Text("Tue")
                        .padding(.horizontal, 7)
                    Text("Wed")
                        .padding(.horizontal, 7)
                    Text("Thurs")
                        .padding(.horizontal, 7)
                    Text("Fri")
                        .padding(.horizontal, 7)
                    Text("Sat")
                        .padding(.horizontal, 7)
                    Text("Sun")
                        .padding(.horizontal, 7)
                }
                hexagon
                Spacer()
            }
            Spacer()
        }
    }
    
//    var month: some View {
//        let month = Calendar.current.monthSymbols
//        return Text("\(month)")
//            .font(.title2)
//            .fontWeight(.bold)
//    }
//    var weekdays: some View {
//        let weekdays = Calendar.current.weekdaySymbols
//        return Text("\(weekdays)")
//            .fontWeight(.semibold)
//    }
    var hexagon: some View {
        let currentMonthCells = allHabitsViewModel.generateCellsForMonth(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()))
        return HexGrid(currentMonthCells) { cell in
            let color = cell.completionStatus ? Color.mediumYellow : Color.lightYellow
            return Hexagon().fill(color).frame(width: 60)
        }
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        return AllHabitsView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
