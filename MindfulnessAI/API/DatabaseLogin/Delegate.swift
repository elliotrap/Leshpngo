
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
            schemaVersion: 7,
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
}
