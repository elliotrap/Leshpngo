//
//  MeditationManager.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 9/26/23.
//

import Foundation
import RealmSwift

// Define a protocol that requires a 'realm' property
protocol RealmFetchable {
    var realm: Realm { get }
}

// Conform your 'MeditationManager' class to the 'RealmFetchable' protocol
class MeditationManager: RealmFetchable {
    let realm: Realm

    init() {
        // Initialize the realm property with your configuration
        do {
            self.realm = try Realm(configuration: Realm.Configuration())
        } catch {
            // Handle initialization errors here
            fatalError("Error initializing Realm: \(error)")
        }
    }
    
    // Add your other methods and properties here
}
