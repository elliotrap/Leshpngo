//
//  UserDataManager.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 12/26/23.
//
import RealmSwift
import Foundation
class UserDataManager {
    static let shared = UserDataManager() // Singleton instance

    private var realm: Realm?
    private var userItem: Item?

    private init() {
        
            // Configure Realm (adjust configuration as needed)
            let config = Realm.Configuration() // Simplified for demonstration; include your actual configuration
            Realm.Configuration.defaultConfiguration = config
            

        do {
            // Try to initialize Realm
            realm = try Realm()

            // Fetch the existing user item if it exists
            userItem = realm?.objects(Item.self).first
            if userItem == nil {
                // Create a new user item if it doesn't exist and save it to Realm
                userItem = Item()
                userItem?.startDate = Date()
                try realm?.write {
                    realm?.add(userItem!)
                }
            }
        } catch {
            print("Error initializing Realm: \(error)")
            // Handle the error appropriately
            // You might choose to set 'realm' to nil or handle it differently
            realm = nil
        }
    }

    func updateUserDuration(with duration: TimeInterval) {
        guard let realm = realm else {
            print("Realm is not initialized")
            return
        }
        
        do {
            try realm.write {
                userItem?.duration += duration
            }
        } catch {
            print("Error updating user duration: \(error)")
        }
    }

    // Other functions to update user data as needed
}

