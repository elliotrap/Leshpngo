//
//  File.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/13/24.
//
import RealmSwift
import Foundation

class deleteAccount: ObservableObject {
    
    enum CustomError: Error {
        case userNotTheTargetUserOrNotLoggedIn(String)
        case deletionFailed(String)
    }

    
    @MainActor
    func deleteUserAndData(userId: String) async throws {
        guard let user = app.currentUser, user.id == userId else {
            throw CustomError.userNotTheTargetUserOrNotLoggedIn("Current user is not the target user or not logged in.")
        }
        do {
            let realm = try await Realm(configuration: user.configuration(partitionValue: "user=\(userId)"))
            
            // Delete all user data
            try realm.write {
                let itemsToDelete = realm.objects(Item.self).filter("userId == %@", userId)
                realm.delete(itemsToDelete)
                // Include deletion of any other user-specific data here
            }
            
            // Continue to delete the user account below
        } catch {
            throw error // Propagate errors
        }
    }

    func deleteUserAccount(userId: String) async throws {
        guard let user = app.currentUser, user.id == userId else {
            throw CustomError.userNotTheTargetUserOrNotLoggedIn("Current user is not the target user or not logged in.")
        }
        
        // Endpoint URL of the webhook/function that handles account deletion
        guard let url = URL(string: "https://your-realm-app-endpoint/deleteAccount") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Include any necessary authentication headers
        request.addValue("Bearer \(String(describing: user.accessToken))", forHTTPHeaderField: "Authorization")
        
        let requestBody = ["userId": userId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check the response to ensure the deletion was successful
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // Handle unsuccessful deletion
                throw CustomError.deletionFailed("Failed to delete user account.")
            }
            
            // Handle successful deletion
            print("Account deletion successful.")
        } catch {
            // Handle errors, such as network issues
            throw error
        }
    }

    
    @MainActor
    func deleteUser(userId: String) async throws {
        do {
            // Step 1: Delete user data from Realm
            try await deleteUserAndData(userId: userId)
            
            // Step 2: Delete user account
            try await deleteUserAccount(userId: userId)
            
            print("User and data deletion successful.")
        } catch {
            print("Deletion error: \(error.localizedDescription)")
            throw error // Propagate the error for external handling
        }
    }

}
