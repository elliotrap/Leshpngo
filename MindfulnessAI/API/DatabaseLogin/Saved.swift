//
//  Saved.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 9/26/23.
//


import Foundation
import RealmSwift

final class Item: Object, Identifiable {
    
    @Persisted(primaryKey: true) var userId: String
    @Persisted var name = ""
    @Persisted var isFavorite = false
    @Persisted var _savedId: Int = 0
    @Persisted var startDate: Date
    @Persisted var duration: TimeInterval = 0
     @Persisted  var realmOpenAIApiKey: String?
     @Persisted var realmGoogleApiKey: String?
   // @Persisted  var realmOpenAIApiKey: List<String>
 //   @Persisted var realmGoogleApiKey: List<String>
    @Persisted(originProperty: "items") var group: LinkingObjects<BackendGroup>
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    @Published var latestAssistantMessage: String = "" {
        didSet {
            self.name = latestAssistantMessage
        }
    }
 var savedId: Int {
     
          get { return _savedId }
          set { _savedId = max(0, newValue) } // Prevents savedId from being negative
      }

    convenience init(name: String, isFavorite: Bool, savedId: Int) {
        self.init()
        self.name = name
        self.isFavorite = isFavorite
        self.latestAssistantMessage = name
        self.savedId = savedId
    }

}
