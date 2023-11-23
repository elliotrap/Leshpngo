//  LoginLogout.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/8/23.
//

import Foundation
import RealmSwift
import SwiftUI

class LoginLogout: ObservableObject {
    

    @ObservedObject var mode: Shapes
    
    @ObservedRealmObject var group: BackendGroup

    @Published var realmConnect: Realm?
    
 
 
    
    init() {
        self.mode = Shapes()
        self.group = BackendGroup()
        if let realm = RealmManager.shared.realm {
            self.realmConnect = realm
        } else {
            // Handle error or assign a default value
        }
    }



    let minLength = 6
    let maxLength = 254
    
    @Published var isLoading = true
    
    @Published var password: String = ""
    
    @Published var reenterPassword: String = ""
    
    @Published var email = ""

    @Published var minEmailLength = 8
        
    @Published var loginReenterPasswordText = ""
    
    @Published var errorMessage = ""
    
    @Published var showErrorMessage = false

    
    @Published var signUpSuccess: Bool = false
    
    @Published var app = App(id: "application-0-kibhk")
    
    @Published private var currentView: AnyView = AnyView(EmptyView())
    
    func isEmailValid(_ email: String, min: Int, max: Int) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email) && email.count >= min && email.count <= max
    }

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

        currentView = AnyView(ChatView(mode: Shapes(), group: group))
        
    }
    


    
    func signup() {
        let client = app.emailPasswordAuth
        isLoading = true
        signUpSuccess = false  // Reset the success flag
        
        client.registerUser(email: email, password: password) { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = "signup error: \(error.localizedDescription)"
                    if error.localizedDescription.contains("already exists") {
                        self?.errorMessage = "An account with this email already exists."
                    }
                } else {
                    self?.signUpSuccess = true
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
