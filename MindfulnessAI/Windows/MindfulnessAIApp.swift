//
//  MindfulnessAIApp.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/16/23.
//

import SwiftUI
import RealmSwift

let app = App(id: "application-0-kibhk")



@main
struct RealmProjectApp: SwiftUI.App{
    
    @ObservedObject var shapeVm = Shapes()
    
    var body: some Scene {
        WindowGroup {
            ContentView(app: app)

        }
    }
}
