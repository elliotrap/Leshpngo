//
//  LoginLogout.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/8/23.
//

import Foundation
import RealmSwift
import SwiftUI

class LoginLogout: ObservableObject {
    
    
    @Published var email = ""
    
    @Published var isLoading = true
    

    
    @Published var password = ""
    
    @Published var loginReenterPasswordText = ""
    
    @Published var errorMessage = "error"
    
    @Published var app = App(id: "application-0-kibhk")
    
    @Published private var currentView: AnyView = AnyView(EmptyView())
    
    func login() {
        
        isLoading = true
        
        let credentials = Credentials.emailPassword(email: email, password: password)
        
        app.login(credentials: credentials) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error): self?.errorMessage = "login failed: \(error.localizedDescription)"
                    case .success(_): print("login success")
                }
                self?.isLoading = false
            }
        }
    }
    func showNextWindow(user: User) {

        currentView = AnyView(ChatView(mode: Shapes()))
        
    }
    
    func signup() {
          
          let client = app.emailPasswordAuth
          
          isLoading = true
        
          
          client.registerUser(email: email, password: password) { [weak self] error in
              DispatchQueue.main.async {
                  if let error = error {
                      self?.errorMessage = "signup error: \(error.localizedDescription)"
                      self?.isLoading = false
                  }
                  else {
                      self?.login()
                  }
              }
              
          }
      }
    
    func logout() {
        // Get the current user
        guard let user = app.currentUser else {
            // No user is logged in, nothing to do
            return
        }

        // Log out the current user
        user.logOut { error in
            if let error = error {
                // Handle the error
                print("Error logging out: \(error.localizedDescription)")
            } else {
                // Log out was successful
                print("Logged out successfully")
            }
        }
    }
}
