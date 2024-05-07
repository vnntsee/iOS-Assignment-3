//
//  AllHabitsView.swift
//  HabitTracker
//
//  Created by Vannesa The on 7/5/2024.
//

import SwiftUI
import HexGrid

struct HexCell: Identifiable, OffsetCoordinateProviding {
    var id: Int { offsetCoordinate.hashValue }
    var offsetCoordinate: OffsetCoordinate
    var colorName: Color
}

struct AllHabitsView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("All Habits")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()                
            }
            .padding()
            Spacer()
            
            Text("May")
                .font(.title2)
                .fontWeight(.bold)
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
            let cells = generateCellsForMonth()
            HexGrid(cells) { cell in
                Color(cell.colorName)
                    .frame(width: 60)
            }
            Spacer()
        }
    }
    func generateCellsForMonth() -> [HexCell] {
        // Determine the number of weeks in a month
        let numberOfWeeksInMonth = 4
        
        // Create cells for each week
        var cells: [HexCell] = []
        for week in 0..<numberOfWeeksInMonth {
            // Assign colors
            let color: Color = week % 2 == 0 ? .mediumYellow : .lightYellow
            
            // Populate cells array with HexCell instances for each week
            for day in 0..<7 {
                cells.append(HexCell(offsetCoordinate: .init(row: week, col: day), colorName: color))
            }
        }
        return cells
    }
}

#Preview {
    AllHabitsView()
}
