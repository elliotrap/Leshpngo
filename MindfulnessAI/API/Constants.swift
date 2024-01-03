//
//  Constants.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 6/20/23.
//

import Foundation
import RealmSwift

//enum Constants {
//    static let openAIApiKey = "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"
//}

enum ConstantsUserAPIKey {
    static var openAIApiKey: String {
        get {
            return retrieveApiKey() ?? ""
        }
        set {
            storeApiKey(newValue)
        }
    }

    private static func storeApiKey(_ key: String) {
         let realm = try! Realm()
         try! realm.write {
             if let settings = realm.objects(Item.self).first {
                 settings.openAIApiKey = key
             } else {
                 let newSettings = Item()
                 newSettings.openAIApiKey = key
                 realm.add(newSettings)
             }
         }
     }

     private static func retrieveApiKey() -> String? {
         let realm = try! Realm()
         return realm.objects(Item.self).first?.openAIApiKey
     }
 }
