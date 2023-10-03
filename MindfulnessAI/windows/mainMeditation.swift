//
//  mainMeditation.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/28/23.
//

import Foundation
import SwiftUI
import AVFoundation
import RealmSwift

struct MainMeditation: View {
    @ObservedObject var mode: Shapes
    @ObservedObject var vm = ViewModel()
    @ObservedObject var shapeVm = Shapes()
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    
    @ObservedRealmObject var group: Group
    let realmConnect = try! Realm()
    let savedItems = Item.self


    @State var playPause = true
    
    @State var goBackward = true
    
    @State var goForward = true
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack {
                    NavigationLink(destination: ChatView(mode: Shapes(), vm: vm, group: group), label:  {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color("homeBrew"))
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 60, height: 40)
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                    .padding(.trailing, 280)
                }
                
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 350, height: 760)
                        .foregroundColor(Color("offBlack"))
                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                    
                    VStack {
                        Text("Léshpngo")
                            .foregroundColor(Color("homeBrew"))
                            .frame(width: 160, height: 70)
                            .modifier(Shapes.NeumorphicBox())
                        
                        ForEach(realmConnect.objects(Item.self), id: \._id) { item in
                            ItemRow(item: item, group: group, mode: mode)
                        }
                    }
                    .scaleEffect(0.9)

                }
                .zIndex(6)
                
                Spacer()
                    .frame(height: 25)
                


   
                
                
                
                VStack {
                    Spacer(minLength: 350)
                    
                }
                .frame(minWidth: 600, maxWidth: 600, minHeight: 0, maxHeight: 0)

            }
            .background(LinearGradient (
                
                gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
                startPoint: .top,
                endPoint: .bottom))
            .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)


        }
    }
}
struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        let group = Group()

        MainMeditation(mode: Shapes(), group: group)
    }
}


