//
//  SwitchWindow.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/9/23.
//

import Foundation
import SwiftUI
import RealmSwift


//struct ContentView: View {
//    @ObservedRealmObject var group: BackendGroup
//    @StateObject var authViewModel = LoginLogout(app: app)
//
//    @EnvironmentObject var authManager: AuthManager
//    var body: some View {
//        
//        Group {
//            if authViewModel.isLoggedIn {
//                ChatView(mode: Shapes(), group: group)
//                    .environment(\.realmConfiguration, authViewModel.app.currentUser!.flexibleSyncConfiguration())
//            } else {
//                DatabaseLoginView(mode: Shapes())
//            }
//        }
//        .onAppear {
//            authViewModel.checkLoginState()
//        }
//    }
//}


struct ContentView: View {
    
    @ObservedObject var app: RealmSwift.App
    var body: some View {
        let group = BackendGroup()

        if let user = app.currentUser {
            ChatView(mode: Shapes(), group: group)
                .environment(\.partitionValue, user.id)
        }
        else {
            DatabaseLoginView(mode: Shapes())

        }
    }
}
