
//
//  AppDelegate.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 10/5/23.
//
import RealmSwift
import SwiftUI

class RealmManager {
    static let shared = RealmManager()
    
    let realm: Realm?
    
    func update(_ block: (() -> Void)) throws {
        do {
            try realm?.write {
                block()
            }
        } catch let error {
            throw error // Propagate the error to handle it in the calling code
        }
    }
    
    private init() {
        // Configure Realm
        let config = Realm.Configuration(
            schemaVersion: 14,
            migrationBlock: { migration, oldSchemaVersion in
                // Your migration logic here
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        // Initialize Realm
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
            realm = nil  // or handle the error in some other way
        }
    }
    // Function to get a Realm instance
      func getRealm() throws -> Realm {
          do {
              let realm = try Realm() // Attempt to initialize a Realm instance with default configuration
              return realm
          } catch {
              throw error // Propagate any errors encountered during initialization
          }
      }
}
