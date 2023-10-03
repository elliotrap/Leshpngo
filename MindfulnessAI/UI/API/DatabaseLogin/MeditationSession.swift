//
//  MeditationSession.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 9/19/23.
//
import Foundation
import RealmSwift

class UsageRecord: Object {
    @Persisted var user: User? // Link the usage record to a user
    @Persisted var totalTimeUsed: TimeInterval = 0.0
}

class User: Object {
    @Persisted var userID: String = ""
    // Add other user-related properties like name, email, etc.
}

