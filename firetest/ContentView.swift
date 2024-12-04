//
//  ContentView.swift
//  firetest
//
//  Created by Faysal Mahmud on 5/12/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @State private var errorMessage = ""
    @State private var isAuthenticated = false
    @State private var isLoggedIn = false
    @State private var loggedInUser: User?
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = loggedInUser {
                    NavigationLink(
                        destination: DataEntryView(user: user),
                                isActive: $isLoggedIn
                    ){
                        EmptyView()
                    }
                }

                Picker("Mode", selection: $isLoginMode) {
                    Text("Login").tag(true)
                    Text("Register").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Email TextField
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                
                // Password SecureField
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Submit Button
                Button(action: {
                    isLoginMode ? login() : register()
                }) {
                    Text(isLoginMode ? "Login" : "Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Register")
        }
    }
    
    // Firebase Login Method
    func login() {
        errorMessage = ""
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            isAuthenticated = true
            if let user = authResult?.user {
                    loggedInUser = user
                    isLoggedIn = true
            }
            print("User logged in successfully")
            email = ""
            password = ""
        }
    }
    
    // Firebase Register Method
    func register() {
        errorMessage = ""
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            
            isAuthenticated = true
            print("User registered successfully")
            email = ""
            password = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
