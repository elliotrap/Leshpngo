//
//  Group.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 9/27/23.
//



import Foundation
import RealmSwift

final class Group: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var items = RealmSwift.List<Item>()

}
