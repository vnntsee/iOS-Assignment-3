//
//  ContentView.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image("Logo")
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
