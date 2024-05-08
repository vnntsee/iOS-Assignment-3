//
//  LoginView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import SwiftUI
import SwiftData

struct LoginView: View {
   
    
    var body: some View {
        Text("Login")
        
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return LoginView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
