//
//  LoginView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Query var users: [User] //Used to access all user records in the database
    @ObservedObject var usersVM = UsersViewModel() //Used to set current user upon successful login.
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                loginTitle
                Spacer()
                habitTrackerLogo
                Spacer()
                usernameField
                passwordField
                incorrectDetailsView
                loginButton
            }
            .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
            .padding(.horizontal)
            //Automatically navigates to tabBarView when the user enters correct credentials.
            .navigationDestination(isPresented: $usersVM.loggedIn, destination: {
                TabBarView()
            })
        }
    }
    
    var loginTitle: some View {
        Text("Log In")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
    
    var habitTrackerLogo: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .frame(height: 200)
            .shadow(radius: 5)
    }
    
    var usernameField: some View {
        VStack {
            Text("Enter your username")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            TextField("Enter username here", text: $usersVM.username)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
        .onTapGesture {
            withAnimation {
                usersVM.incorrectDetails = false
            }
        }
    }
    
    var passwordField: some View {
        VStack {
            Text("Enter your password")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            SecureField("Enter password here", text: $usersVM.password)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
        .onTapGesture {
            withAnimation {
                usersVM.incorrectDetails = false
            }
        }
    }
    
    var loginButton: some View {
        Button {
            usersVM.validateCredentials(users: users)
        } label: {
            Text("Log In!")
                .font(.headline)
                .foregroundColor(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
                .fontWeight(.bold)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)
                .background(Color(UIColor(named: "EarthYellow") ?? UIColor(Color.orange)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
                .padding()
        }
    }
    
    var incorrectDetailsView: some View {
        HStack {
            Image(systemName: "multiply.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text("Incorrect credentials.")
                Text("Please try again.")
            }
            Spacer()
        }
        .font(.headline)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .foregroundColor(.white)
        .padding(.vertical)
        .opacity(usersVM.incorrectDetails ? 1 : 0)
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
