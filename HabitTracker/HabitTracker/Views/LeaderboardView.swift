//
//  LeaderboardView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 2/5/2024.
//

import SwiftData
import SwiftUI

struct LeaderboardView: View {
    @Query var users: [User]
    //modelContext tracks all objects and CRUD operations related to them, allowing for them to be saved to the modelContainer(defined in App struct) later on.
    @Environment(\.modelContext) var modelContext
    
    //DELETE: Sample data for preview
    @State var sampleUsers: [User] = [User(name: "Jane Doe", points: 5000, ranking: 1), User(name: "John Doe", points: 4300, ranking: 2), User(name: "Jack Jones", points: 1504, ranking: 3), User(name: "Joe Roberts", points: 1100, ranking: 4)]
    @State var currUser: User = User(name: "John Doe", points: 4300, ranking: 2)

    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                leaderboardTitle
                currentUserRanking
                ScrollView {
                    userRankingRows
                }
                .padding()
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .fontWeight(.bold)
        }
      //  Button("Add Sample User", action: addSampleUsers) //REMOVE
      //  Button("Delete Users", action: removeUsers) //REMOVE
    }
    
//    //REMOVE
//    func addSampleUsers() {
//        let user1 = User(name: "Jane", points: 5000, ranking: 1)
//        let user2 = User(name: "John", points: 4300, ranking: 2)
//        let user3 = User(name: "Jack", points: 1504, ranking: 3)
//        modelContext.insert(user1)
//        modelContext.insert(user2)
//        modelContext.insert(user3)
//    }
//    
//    //REMOVE
//    func removeUsers() {
//        for user in users {
//            modelContext.delete(user)
//        }
//    }
    
    var leaderboardTitle: some View {
        Text("Leaderboard")
            .font(.title)
            .fontWeight(.bold)
            .padding()
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
                Text("\(currUser.ranking)")
            }
            Spacer()
            VStack {
                profileImage
                    .frame(width: 120)
                Text(currUser.name)
            }
            Spacer()
            Text("\(currUser.points)")
        }
        .font(.title)
        .padding()
        .background(Color(UIColor(named: "PastelYellow") ?? UIColor(Color.orange)))
        .frame(maxWidth: .infinity)
    }
    
    var userRankingRows: some View {
        ForEach(sampleUsers) { user in
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
