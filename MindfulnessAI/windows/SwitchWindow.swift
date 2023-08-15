//
//  SwitchWindow.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/9/23.
//

import Foundation
import SwiftUI
import RealmSwift


struct ContentView: View {
    
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        if let user = app.currentUser {
            ChatView(mode: Shapes())
                .environment(\.partitionValue, user.id)
           
        }
        else {
            DatabaseLoginView()

        }
    }
}
