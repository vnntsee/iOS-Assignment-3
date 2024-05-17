//
//  LeaderboardView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 2/5/2024.
//

import SwiftData
import SwiftUI

struct LeaderboardView: View {
    @Query(sort: [SortDescriptor(\User.points, order: .reverse)]) var users: [User]
    //modelContext tracks all objects and CRUD operations related to them, allowing for them to be saved to the modelContainer(defined in App struct) later on.
    @Environment(\.modelContext) var modelContext
    @ObservedObject var usersVM: UsersViewModel = UsersViewModel()
    
    var body: some View {
        
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                leaderboardTitle
                currentUserRanking
                Spacer()
                ScrollView {
                    userRankingRows
                }
                .padding()
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .fontWeight(.bold)
        }
        .onAppear {
            updateRanking()
        }
    }
    
    func updateRanking() {
        usersVM.updateUsersRanking(users: users)
    }
    
    
    var leaderboardTitle: some View {
        Text("Leaderboard")
            .font(.title)
            .fontWeight(.bold)
    }
    
    var rankingStar: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundStyle(Color(UIColor(named: "PastelYellow") ?? UIColor(Color.white)))
    }
    
    var profileImage: some View {
        Image("DefaultProfile")
            .resizable()
            .scaledToFit()
            .padding(5)
    }
    
    var currentUserRanking: some View {
        HStack {
            ZStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundStyle(Color(UIColor(named: "MediumYellow") ?? UIColor(Color.white)))
                Text("\(usersVM.getUser(users: users).ranking)")
            }
            Spacer()
            VStack {
                profileImage
                    .frame(width: 120)
                Text("\(usersVM.getUser(users: users).name)")
            }
            Spacer()
            Text("\(usersVM.getUser(users: users).points)")
                .frame(minWidth: 90)
        }
        .font(.title)
        .padding()
        .background(Color(UIColor(named: "PastelYellow") ?? UIColor(Color.orange)))
        .frame(maxWidth: .infinity)
    }
    
    var userRankingRows: some View {
        ForEach(users) { user in
            HStack {
                ZStack {
                    rankingStar
                    Text("\(user.ranking)")
                        .font(.title2)
                }
                
                profileImage
                Text(user.name)
                Spacer()
                Text("\(user.points)")
            }
            .padding(.horizontal)
            .frame(height: 70)
            .background(Color(UIColor(named: "EarthYellow") ?? UIColor(Color.orange)))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    //Stores temporary data and SwiftData configuration for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return LeaderboardView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
