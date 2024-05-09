//
//  ContentView.swift
//  HabitTracker
//
//  Created by Vannesa The on 30/4/2024.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @State private var navigateToTabBarView = false
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                HStack {
                    loginLink
                    signUpLink
                }
                //REMOVE
                NavigationLink (destination: TabBarView(), label: {
                    Text("TabBarView")
                })
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .font(.title2)
            .fontWeight(.bold)
        }
    }
    
    var loginLink: some View {
        NavigationLink (destination: LoginView(), label: {
            ZStack {
                Image(systemName: "hexagon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundStyle(Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow)))
                Text("Log In")
            }
        })
        .padding(.trailing)
    }
    
    var signUpLink: some View {
        NavigationLink (destination: SignUpView(), label: {
            ZStack {
                Image(systemName: "hexagon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundStyle(Color(UIColor(named: "MediumYellow") ?? UIColor(Color.orange)))
                Text("Sign Up")
            }
        })
        .padding(.leading)
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return HomeView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
