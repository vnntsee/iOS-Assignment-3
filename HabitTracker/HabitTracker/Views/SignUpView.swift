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
    @Query var user: [User]
    
    @State private var name: String = ""
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
                nameField
                passwordField
                signUpResultField
                signUpButton
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

    var nameField: some View {
        VStack {
            Text("Enter your name")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            TextField("Enter your name", text: $name)
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
            TextField("Choose a password", text: $password)
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
        //Toggles between being a sign up button and a login button, the latter being displayed when user info has been entered and validated with the sign up button.
        Button {
            if signedUp {
                
            }
            else {
                validateUserDetails()
            }
        } label: {
            Text(signedUp ? "Log In!" : "Sign Up!")
                .font(.headline)
                .foregroundColor(signedUp ? .white : Color(UIColor(named: "DarkBrown") ?? UIColor(Color.black)))
                .fontWeight(.bold)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)
                .background(signedUp ? Color.green : Color(UIColor(named: "EarthYellow") ?? UIColor(Color.orange)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
                .padding()
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
            Text("Welcome to HabitTracker user's name!")
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
        guard !name.isEmpty && !password.isEmpty else {
            withAnimation {
                incorrectDetails = true
            }
            return
        }
        //Displays signed up message if details are valid.
        withAnimation {
            incorrectDetails = false
            signedUp = true
        }
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
