//
//  ProfileView.swift
//  HabitTracker
//
//  Created by Vannesa The on 6/5/2024.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    // State variable for toggling dark mode
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    //@State var currUser: User = User(name: "John Doe", points: 4300, ranking: 2, longestStreak: 55)
    
    @Query(sort: [SortDescriptor(\User.points, order: .reverse)]) var users: [User]
    @Environment(\.modelContext) var modelContext
    @ObservedObject var usersVM = UsersViewModel()
    @State var loggedOut = false
    
    var body: some View {
        // Background setup
        ZStack {
            Color(UIColor(named: "PastelYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            // Content layout
            VStack {
                // User's name
                Text("\(usersVM.getUser(users: users).name)")
                    .font(.title)
                    .fontWeight(.black)
                // User's profile image
                Image("DefaultProfile")
                    .padding(.bottom, 20)
                // User's statistics
                VStack (alignment: .leading, spacing: 20) {
                    Text("Points: \(usersVM.getUser(users: users).points)")
                    Text("Longest Streak: \(usersVM.getUser(users: users).longestStreak)")
                    Text("Ranking: \(usersVM.getUser(users: users).ranking)")
                        .padding(.bottom, 20)
                    // Dark mode toggle
                    HStack {
                        Toggle(isOn: $isDarkMode, label: {
                            Text("Dark Mode")
                        })
                    }
                    logOutButton
                    deleteAccountButton
                }
                .font(.title3)
                .fontWeight(.semibold)
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .navigationDestination(isPresented: $loggedOut, destination: {
                HomeView()
            })
            .padding(40)
            // Change the colorScheme based on isDarkMode state variable
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
    
    var logOutButton: some View {
        Button {
            usersVM.logout()
            loggedOut = true
        } label: {
            Text("Logout")
                .frame(width: 130)
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .background(Color(UIColor(named: "EarthYellow") ?? UIColor(Color.orange)))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    var deleteAccountButton: some View {
        Button {
            deleteUser()
            loggedOut = true
        } label: {
            Text("Delete Account")
                .foregroundStyle(Color.white)
                .frame(width: 130)
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    func deleteUser() {
        for user in users {
            if user.name == usersVM.currUserStr {
                modelContext.delete(user)
                break
            }
        }
    }
    
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return ProfileView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
