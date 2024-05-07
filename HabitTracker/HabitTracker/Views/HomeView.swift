//
//  ContentView.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
        }
    }
}

#Preview {
    HomeView()
}
