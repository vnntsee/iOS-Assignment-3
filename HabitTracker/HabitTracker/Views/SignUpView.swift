//
//  SignUpView.swift
//  HabitTracker
//
//  Created by Negin Ghanavi on 8/5/2024.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    // Environment property for accessing the model context
    @Environment(\.modelContext) var modelContext
    // Query property used to access all user records in the database
    @Query var users: [User]
    // ObservedObject for managing sign-up functionality
    @ObservedObject var signUpVM = SignUpViewModel()
    
    var body: some View {
        ZStack {
            // Background color with light yellow
            Color(UIColor(named: "LightYellow") ?? UIColor(Color.yellow.opacity(0.4)))
                .ignoresSafeArea(.all) // Ensures the color covers the entire screen
            
            VStack {
                signUpTitle // Title of the sign-up view
                Spacer()
                habitTrackerLogo // Habit Tracker logo
                Spacer()
                // Username and password input fields
                usernameField
                passwordField
                signUpResultField // Sign-up result message field
                signUpLoginButton // Sign-up button
            }
            .padding(.horizontal)
        }
        .foregroundStyle(Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
    }
    
    // Habit Tracker Logo
    var habitTrackerLogo: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .frame(height: 200)
            .shadow(radius: 5)
    }
    
    // Title of the sign-up view
    var signUpTitle: some View {
        Text("Sign Up")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }

    // Username input field
    var usernameField: some View {
        VStack {
            Text("Choose a username")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            TextField("Enter username here", text: $signUpVM.username)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
        .onTapGesture { //Removes incorrect details message from view when name field is selected
            withAnimation {
                signUpVM.incorrectDetails = false
            }
        }
    }

    // Password input field
    var passwordField: some View {
        VStack {
            Text("Choose a password")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            SecureField("Enter password here", text: $signUpVM.password)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
        .onTapGesture {
            //Removes incorrect details message from view when password field is selected
            withAnimation {
                signUpVM.incorrectDetails = false
            }
        }
    }
    
    // Button for signing up
    var signUpButton: some View {
        Button {
            signUpVM.validateCredentials(users: users)
            if signUpVM.signedUp {
                addUser()
            }
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
    
    // Link for navigating to login view
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
    // Button for signing up
    var signUpLoginButton: some View {
        //Toggles between being a sign up button and a login button, the latter being displayed when user info has been entered and validated with the sign up button.
        ZStack {
            signUpButton.opacity(signUpVM.signedUp ? 0 : 1)
            loginLink.opacity(signUpVM.signedUp ? 1 : 0)
        }
    }
    
    // View for displaying incorrect sign-up details
    var incorrectDetailsView: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(signUpVM.signUpErr)
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
    
    // View for displaying successful sign-up message
    var successfulSignUpView: some View {
        VStack {
            Text("Welcome to HabitTracker \(signUpVM.username)!")
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
    
    // Field for displaying sign-up result message
    var signUpResultField: some View {
        //Message that doesn't apply is hidden based on state variable values.
        ZStack {
            incorrectDetailsView
                .opacity(signUpVM.incorrectDetails ? 1 : 0)
            successfulSignUpView
                .opacity(signUpVM.signedUp ? 1 : 0)
        }
        .padding(.vertical)
    }
    
    // Function to add a user to the database
    func addUser() {
        //Adds user to the database.
        let newUser = User(name: signUpVM.username, password: signUpVM.password)
        modelContext.insert(newUser)
        signUpVM.signedUp = true
    }
}

#Preview {
    //Stores temporary data for preview.
    do {
        // Configuration for in-memory storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // Creating a model container
        let container = try ModelContainer(for: User.self, configurations: config)
        // Attaches the model container to the view
        return SignUpView()
            .modelContainer(container)
        // Handles any errors in creating the model container
    } catch {
        fatalError("Failed to create model container.")
    }
}
