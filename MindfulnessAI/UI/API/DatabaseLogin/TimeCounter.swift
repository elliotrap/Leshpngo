//
//  TimeCounter.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/9/23.
//


import Foundation
import RealmSwift

class Counter: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var startTime: Date?
    @Persisted var endTime: Date?
    

    
    
    var elapsedTime: TimeInterval? {
        guard let startTime = startTime, let endTime = endTime else {
            return nil
        }
        return endTime.timeIntervalSince(startTime)
    }
    
    func start() {
        startTime = Date()
    }
    
    func stop() {
        endTime = Date()
    }
}
