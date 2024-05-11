//
//  SignUpView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var incorrectDetails: Bool = false
    @State private var signedUp: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all)
            VStack {
                signUpTitle
                Spacer()
                habitTrackerLogo
                Spacer()
                usernameField
                passwordField
                signUpResultField
                signUpLoginButton
            }
            .padding(.horizontal)
        }
        .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
    }
    
    var habitTrackerLogo: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .frame(height: 200)
            .shadow(radius: 5)
    }
    
    var signUpTitle: some View {
        Text("Sign Up")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }

    var usernameField: some View {
        VStack {
            Text("Choose a username")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            TextField("Enter username here", text: $username)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
        .onTapGesture { //Removes incorrect details message from view when name field is selected
            withAnimation {
                incorrectDetails = false
            }
        }
    }

    var passwordField: some View {
        VStack {
            Text("Choose a password")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            SecureField("Enter password here", text: $password)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
        .onTapGesture {
            withAnimation {
                incorrectDetails = false
            }
        }
    }
    
    var signUpButton: some View {
        Button {
            validateUserDetails()
        } label: {
            Text("Sign Up!")
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
    
    var loginLink: some View {
        NavigationLink(destination: LoginView(), label: {
            Text("Log In!")
                .font(.headline)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
                .padding()
        })
    }
    
    var signUpLoginButton: some View {
        //Toggles between being a sign up button and a login button, the latter being displayed when user info has been entered and validated with the sign up button.
        ZStack {
            signUpButton.opacity(signedUp ? 0 : 1)
            loginLink.opacity(signedUp ? 1 : 0)
        }
    }
    
    var incorrectDetailsView: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
            Text("Please enter your details.")
        }
        .font(.headline)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .foregroundColor(.white)
    }
    
    var successfulSignUpView: some View {
        VStack {
            Text("Welcome to HabitTracker \(username)!")
            HStack {
                Text("Log into your account")
                Image(systemName: "arrow.down")
            }
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .fontWeight(.bold)
        .padding()
        .background(Color.green)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
    
    var signUpResultField: some View {
        //Message that doesn't apply is hidden based on state variable values.
        ZStack {
            incorrectDetailsView
                .opacity(incorrectDetails ? 1 : 0)
            successfulSignUpView
                .opacity(signedUp ? 1 : 0)
        }
        .padding(.vertical)
    }
    
    func validateUserDetails() {
        //Displays error message if name and password fields are left blank.
        guard !username.isEmpty && !password.isEmpty else {
            withAnimation {
                incorrectDetails = true
            }
            return
        }
        //Displays signed up message and adds user to database if details are valid.
        withAnimation {
            incorrectDetails = false
            signedUp = true
            addUser()
        }
    }
    
    func addUser() {
        //Adds user to the database.
        let newUser = User(name: username, password: password)
        modelContext.insert(newUser)
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return SignUpView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
