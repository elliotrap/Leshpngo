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

//let apiKey = "AIzaSyDf2LDCrnMC1fnEaZN5-iNYh8f9EOMjH1I"

class APIManager {
    @Published var currentUserIdentifier = "user123"
    
    @Published var apiKey = "your_api_key_here"
    static var currentUserIdentifier: String = "" // Example static property

    enum ConstantsUserAPIKey {
        static var openAIApiKey: String {
            get {
                print("get openAI key")
                return retrieveApiKey() ?? ""
            }
            set {
                storeApiKey(for: currentUserIdentifier, newValue) {
                    print("Stored API Key: \(newValue)")
                }
            }
        }
            private static func storeApiKey(for userId: String, _ key: String, completion: @escaping () -> Void) {
                DispatchQueue.global().async {
                    do {
                        let realm = try Realm()
                        try realm.write {
                            if let settings = realm.objects(Item.self).first {
                                settings.realmOpenAIApiKey = key
                            } else {
                                let newSettings = Item()
                                newSettings.realmOpenAIApiKey = key
                                realm.add(newSettings)
                            }
                        }
                        DispatchQueue.main.async {
                            completion()
                        }
                    } catch {
                        print("Realm error: \(error)")
                        // Handle the error appropriately
                    }
                }
            }
        }

        

        
    private static func retrieveApiKey() -> String? {
        do {
            let realm = try Realm()
            if let settings = realm.objects(Item.self).first {
                print("Retrieved API Key: \(String(describing: settings.realmOpenAIApiKey))")
                return settings.realmOpenAIApiKey
            } else {
                print("No settings found in Realm")
                return nil
            }
        } catch {
            print("Error retrieving API key from Realm: \(error)")
            return nil
        }
    }
    
    

    
    enum ConstantsUserGoogleAPIKey {
        
        static var GoogleApiKey: String {
            get {
                print("get Google key")
                return retrieveApiKey() ?? ""
            }
            set {
                // Correctly use `newValue` as the parameter for the `storeApiKey` function
                storeApiKey(for: currentUserIdentifier, newValue) {
                    // Completion handler code
                    print("API key stored successfully for user \(currentUserIdentifier)")
                }
            }
        }
        
        private static func storeApiKey(for userId: String, _ key: String, completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                do {
                    let realm = try Realm()
                    try realm.write {
                        if let settings = realm.objects(Item.self).first {
                            settings.realmOpenAIApiKey = key
                        } else {
                            let newSettings = Item()
                            newSettings.realmOpenAIApiKey = key
                            realm.add(newSettings)
                        }
                    }
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    print("Realm error: \(error)")
                    // Handle the error appropriately
                }
            }
        }
    }


        private static func storeApiKey(for userId: String, _ key: String, completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                do {
                    let realm = try Realm()
                    try realm.write {
                        // Find or create an Item object for the current user
                        let settings = realm.objects(Item.self).filter("userId == %@", userId).first
                        if let existingSettings = settings {
                            // Update the existing item
                            existingSettings.realmGoogleApiKey = key
                        } else {
                            // Create a new item if it doesn't exist
                            let newSettings = Item()
                           // newSettings.userId = id // Set the userId
                            newSettings.realmGoogleApiKey = key
                            realm.add(newSettings)
                        }
                    }
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    print("Realm error: \(error)")
                    // Handle the error appropriately
                }
            }
        }
        
        

    }

