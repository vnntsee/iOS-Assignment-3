//
//  ProfileView.swift
//  HabitTracker
//
//  Created by Vannesa The on 6/5/2024.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var currUser: User = User(name: "John Doe", points: 4300, ranking: 2, longestStreak: 55)
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                Text("\(currUser.name)")
                    .font(.title)
                    .fontWeight(.black)
                Image("DefaultProfile")
                    .padding(.bottom, 20)
                VStack (alignment: .leading, spacing: 20) {
                    Text("Points: \(currUser.points)")
                    Text("Longest Streak: \(currUser.longestStreak)")
                    Text("Ranking: \(currUser.ranking)")
                        .padding(.bottom, 20)
                    HStack {
                        Toggle(isOn: $isDarkMode, label: {
                            Text("Dark Mode")
                        })
                    }
                }
                .font(.title3)
                .fontWeight(.semibold)
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .padding(40)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    ProfileView()
}
