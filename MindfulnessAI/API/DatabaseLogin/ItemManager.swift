//
//  ItemManager.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 12/5/23.
//

import Foundation
import RealmSwift
class ItemManager: ObservableObject {
    
    private var realmConnect: Realm
       private var savedIdCounter: Int

       // Default initializer
    init() {
        if let realm = RealmManager.shared.realm {
            self.realmConnect = realm
            self.savedIdCounter = 0
            self.savedIdCounter = self.calculateMaxSavedId()
        } else {
            fatalError("Failed to initialize Realm")
        }
        do {
            realmConnect = try Realm()
     
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }

       // Existing initializer with realm parameter
       init(realm: Realm) {
           self.realmConnect = realm
           self.savedIdCounter = 0   // Provide an initial value for savedIdCounter

           self.savedIdCounter = self.calculateMaxSavedId()
       }
    private func calculateMaxSavedId() -> Int {
        return realmConnect.objects(Item.self).max(ofProperty: "_savedId") as Int? ?? 0
    }



    func addItem(name: String, isFavorite: Bool) {
        let newItem = Item(name: name, isFavorite: isFavorite, savedId: savedIdCounter + 1)

        try? realmConnect.write {
            realmConnect.add(newItem)
        }

        savedIdCounter += 1 // Increment the counter after adding an item
    }

    func deleteItem(_ item: Item) {
        if let newItem = item.thaw(),
           let realm = newItem.realm {
            try? realm.write {
                realm.delete(newItem)
            }
        }

        // Decide if you need to decrement the counter here
        // Typically, you would not decrement to avoid reusing unique identifiers
    }
}
