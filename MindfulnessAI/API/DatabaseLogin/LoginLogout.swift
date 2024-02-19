//  LoginLogout.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/8/23.
//

import Foundation
import RealmSwift
import SwiftUI


//class AuthManager: ObservableObject {
//    var isAuthenticated: Bool = false
//    let app: RealmSwift.App
//
//    init() {
//        app = App(id: "application-0-yancq")
//        
//        // Asynchronously check if the user is already logged in
//        DispatchQueue.main.async {
//            if let user = self.app.currentUser, user.isLoggedIn {
//                self.isAuthenticated = true // Set to true if there is a logged-in user
//            } else {
//                self.isAuthenticated = false // Set to false if no user is logged in
//            }
//        }
//    }
//}


class LoginLogout: ObservableObject {

    
    init() {
        // Set the initial login state
        self.mode = Shapes()
        self.group = BackendGroup()
        if let realm = RealmManager.shared.realm {
            self.realmConnect = realm
        } else {
            // Handle error or assign a default value
        }
    }

  

    static let shared = LoginLogout()


    @ObservedObject var mode: Shapes
    
    @ObservedRealmObject var group: BackendGroup
    
    @Published var realmConnect: Realm?
    
    @Published var user: User?
    @Published var configuration: Realm.Configuration?
    
    
    
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
    
    
    @Published private var currentView: AnyView = AnyView(EmptyView())
    
    // Token and tokenId are query parameters in the confirmation
    // link sent in the confirmation email.
    @Published var token: String = "someToken"
    @Published var tokenId: String = "someTokenId"
    
    func isEmailValid(_ email: String, min: Int, max: Int) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email) && email.count >= min && email.count <= max
    }
    
 
    
    func logout() async {
        guard let user = app.currentUser else {
            print("no user to logout")
            return
        }
        
        do {
            try await user.logOut()
            DispatchQueue.main.async {
                
                // Ensure we update the UI on the main thread
                print("Logged out successfully")
            }
        } catch {
            DispatchQueue.main.async {
                print("Error logging out: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func login() async {
        isLoading = true
        do {
            let user = try await app.login(credentials: .emailPassword(email: email, password: password))
            let configuration = user.flexibleSyncConfiguration()
            
            let realm = try await Realm(configuration: configuration, downloadBeforeOpen: .always)
            print("Login and Realm configuration successful.")
            
            realmConnect = realm
        
        
            fetchInitialData(realm)
        } catch {
            print("Login failed: \(error.localizedDescription)")
            // Consider how to handle this error, e.g., showing an alert to the user
        }
        isLoading = false
    }


    private func fetchInitialData(_ realm: Realm) {
        // Fetch objects of type Item from Realm
        let items = realm.objects(Item.self)

        // Perform any initial setup or data processing needed
        // For example, iterating over the items and performing an action:
        for item in items {
            // Perform an action with each item
            // Example: print item details, update UI, etc.
            print("Item: \(item)")
        }

        // If you need to update your UI based on the fetched items,
        // ensure you dispatch those updates on the main thread.
        DispatchQueue.main.async {
            // Update your UI here
            // Example: self.itemsList = items.toArray()
        }

        // If you have any additional setup or data processing, add it here
        // ...
    }


    
    
    func showNextWindow(user: User) {
        
        currentView = AnyView(ChatView(mode: Shapes(), group: group))
        
    }
    
    enum MyError: Error {
        case userNotFound
    }


    @MainActor
    func setupFlexibleSyncConfiguration(for user: User) async throws {
        guard let user = self.user else {
            throw MyError.userNotFound // You need to define MyError.userNotFound or use an existing error that fits
        }
        let userId = user.id // Accessed on the main actor

        // Now, use userId within your closure without directly accessing `user`
        self.configuration = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
            if subs.first(named: "user-items-\(userId)") == nil {
                subs.append(QuerySubscription<Item>(name: "user-items-\(userId)"))
            }
        }, rerunOnOpen: true)
    }


    
    
    @MainActor
    func signup() async throws {
        isLoading = true
        signUpSuccess = false // Reset the success flag
        
        do {
            // Create user with username/password
            let client = app.emailPasswordAuth
            try await client.registerUser(email: email, password: password)
            
            // Registration successful, now login the user
            user = try await app.login(credentials: .emailPassword(email: email, password: password))
            
            // Define a flexible sync configuration
            if let loggedInUser = self.user {
                try await setupFlexibleSyncConfiguration(for: loggedInUser)
            }
            
            
            // Open the Realm asynchronously, which will trigger the user's subscriptions to be evaluated
            realmConnect = try await Realm(configuration: configuration!, downloadBeforeOpen: .always)
            
            // Now that the Realm is open, associate this user with a unique userId in your database
            // This is a good place to create or update a user profile object in your Realm database
            try! realmConnect?.write {
                // Check if a user profile already exists, otherwise create a new one
                if let userProfile = realmConnect?.objects(Item.self).filter("userId == %@", user?.id ?? "").first {
                    // Update existing profile if needed
                } else {
                    let item = Item()
                    // Create a new profile for the user
                    let newUserProfile = UserProfile()
                    // Now you can use 'item' as needed, for example, adding it to Realm
                    try! realmConnect?.write {
                        realmConnect!.add(item)
                    }
                }
            }
            
            // Handle the successful sign up and realm opening here
            print("Sign up and Realm configuration successful.")
            
            // Update the success flag
            signUpSuccess = true
            isLoading = false
        } catch {
            // Handle errors, such as if the user already exists
            isLoading = false
            if error.localizedDescription.contains("already exists") {
                errorMessage = "An account with this email already exists."
            } else {
                errorMessage = "Sign up error: \(error.localizedDescription)"
            }
            throw error // If you want to
            
            
        }
    }
    // If Realm is set to send a confirmation email, we can
    // send the confirmation email again here.
    func sendSignupEmail() async {
        let client = app.emailPasswordAuth
        
        do {
            try await client.resendConfirmationEmail(email)
            // The confirmation email has been sent
            // to the user again.
            print("Confirmation email resent")
        } catch {
            print("Failed to resend confirmation email: \(error.localizedDescription)")
        }
    }
    
    func confirmPassword() async {
        let client = app.emailPasswordAuth
        
        
        do {
            try await client.confirmUser(token, tokenId: tokenId)
            // User email address confirmed.
            print("Successfully confirmed user.")
        } catch {
            print("User confirmation failed: \(error.localizedDescription)")
        }
    }
//    @MainActor
//    func deleteUserAccount() async throws {
//        guard let user = self.user else {
//            // Handle the case where there is no user logged in
//            print("No user is currently logged in.")
//            return
//        }
//        
//        do {
//            let realm = try await Realm(configuration: user.configuration(partitionValue: "user=\(user.id)"), downloadBeforeOpen: .never)
//            
//            // Delete all user data from Realm
//            try realm.write {
//                let allUserData = realm.objects(Item.self).filter("userId == %@", user.id)
//                realm.delete(allUserData)
//            }
//            
//            // Delete the account from MongoDB Realm App - This requires backend support
//            // You might need to call a custom function or use a specific API provided by MongoDB Realm
//            try await app.emailPasswordAuth.resetFunc(user: user)
//            
//            print("User account and data deleted successfully.")
//        } catch {
//            // Handle possible errors
//            print("Failed to delete user account and data: \(error.localizedDescription)")
//            throw error
//        }
//    }

    // Placeholder for your logout logic




    
    //     func signUp() {
    //         let app = App(id: "application-0-yancq")
    //         app.emailPasswordAuth.registerUser(email: email, password: password) { (error) in
    //             if let error = error {
    //                 // Handle sign up error
    //                 self.errorMessage = "Sign up failed: \(error.localizedDescription)"
    //             } else {
    //                 // Sign up success, proceed with login or other actions
    //                 self.errorMessage = "Sign up successful!"
    //             }
    //         }
    //     }
    
//    func login() {
//
//        isLoading = true
//
//        let credentials = Credentials.emailPassword(email: email, password: password)
//
//        app.login(credentials: credentials) { [weak self]  result in
//            DispatchQueue.main.async {
//                switch result {
//                    case .failure(let error): self?.errorMessage = "login failed: \(error.localizedDescription)"
//                    case .success(_): print("login success")
//                }
//                self?.isLoading = false
//            }
//        }
//    }
    
//    func logout() {
//        // Get the current user
//        guard let user = app.currentUser else {
//            // No user is logged in, nothing to do
//            return
//        }
//
//        // Log out the current user
//        user.logOut { error in
//            if let error = error {
//                // Handle the error
//                print("Error logging out: \(error.localizedDescription)")
//            } else {
//                // Log out was successful
//                print("Logged out successfully")
//            }
//        }
//    }
    
//        func signup() {
//            let client = app.emailPasswordAuth
//            isLoading = true
//            signUpSuccess = false  // Reset the success flag
//    
//            client.registerUser(email: email, password: password) { [weak self] error in
//                DispatchQueue.main.async {
//                    self?.isLoading = false
//                    if let error = error {
//                        self?.errorMessage = "signup error: \(error.localizedDescription)"
//                        if error.localizedDescription.contains("already exists") {
//                            self?.errorMessage = "An account with this email already exists."
//                        }
//                    } else {
//                        self?.signUpSuccess = true
//                        self?.login()
//                    }
//                }
//            }
//        }
}
