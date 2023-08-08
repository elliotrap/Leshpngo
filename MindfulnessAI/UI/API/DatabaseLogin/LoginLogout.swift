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
        // Create a credentials object with the email and password
        let credentials = Credentials.emailPassword(email: email, password: password)
        
        // Log in to the Realm app with the credentials
        app.login(credentials: credentials) { result in
            switch result {
            case .success(let user):
                // Login was successful, show the next view
                self.showNextWindow(user: user)
            case .failure(let error):
                // Login failed, show an error message
                self.errorMessage = "Login failed: \(error.localizedDescription)"
            }
        }
  
    }
    func showNextWindow(user: User) {
        // Assign the ChatView instance to the currentView property
        currentView = AnyView(ChatView())
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
}
