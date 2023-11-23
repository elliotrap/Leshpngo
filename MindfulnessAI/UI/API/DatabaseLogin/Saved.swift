//
//  Saved.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 9/26/23.
//


import Foundation
import RealmSwift

final class Item: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
    @Persisted var isFavorite = false
    @Persisted var savedId: Int = 0
    @Persisted var startDate: Date
    @Persisted var duration: TimeInterval = 0
    @Persisted(originProperty: "items") var group: LinkingObjects<BackendGroup>

    @Published var latestAssistantMessage: String = "" {
        didSet {
            self.name = latestAssistantMessage
        }
    }
    

    
    convenience init(name: String, isFavorite: Bool, savedId: Int) {
        self.init()
        self.name = name
        self.isFavorite = isFavorite
        self.latestAssistantMessage = name
        self.savedId = savedId
    }
}
