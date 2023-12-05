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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var mode: Shapes
    @ObservedObject var vm = ViewModel()
    @ObservedObject var shapeVm = Shapes.shared
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    @ObservedResults(Item.self) var items
    @ObservedRealmObject var group: BackendGroup
    let savedItems = Item.self


    @State var playPause = true
    
    @State var goBackward = true
    
    @State var goForward = true
    
    var body: some View {
        NavigationView {
        
            ZStack {
              
                VStack {
                    Spacer()
                        .frame(height: 40)
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(Color("homeBrew"))// Customize color
                            }})
                        .buttonStyle(.borderless)
                        .frame(width: 60, height: 40)
                        .modifier(Shapes.NeumorphicBackCircle(mode: mode))
                        .padding(.trailing, 280)
                        
                    }
                VStack {
                    Spacer()
                        .frame(height: 30)
                    ZStack(alignment: .top) {
                        
                        
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 350, height: 670)
                            .foregroundColor(Color("offBlack"))
                            .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                        
                        VStack {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius:30)
                                    .frame(width:110, height: 55)
                                    .modifier(Shapes.NeumorphicClickedBox())


                                Text("Saved")
                                    .fontWeight(.thin)
                                
                                    .foregroundColor(Color("homeBrew"))
                                    .frame(width: 160, height: 70)
                            }
                            Spacer()
                                .frame(height: 640)
                            
                        }
                        VStack {
                            
                            Spacer()
                                .frame(height: 100)
                            if let firstItem = items.first, firstItem.savedId == 0 {
                                 Text("Save a meditation in the meditation generator window")
                                    .fontWeight(.thin)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .frame(width: 300)
                            }
                       
                            if let unwrappedRealm = realm.realmConnect {
                                ForEach(unwrappedRealm.objects(Item.self), id: \._id) { item in
                                    ItemRow(item: item, group: group, mode: mode)
                                }
                            }
                        }
                        .scaleEffect(0.9)
                    }
                    .zIndex(6)
                    
                    Spacer()
                        .frame(height: 25)
                }
            }
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
struct ItemRow: View {
    
    @ObservedRealmObject var item: Item
    @ObservedObject var vm = ViewModel()
    @ObservedRealmObject var group: BackendGroup
    @ObservedObject var mode: Shapes
    @ObservedObject var viewModel = ChatViewModel.shared

    @State var savedButtonExpand = false
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 30)
                .stroke()
                .foregroundColor(Color("homeBrewSelect"))
                .frame(width:  305, height: savedButtonExpand ? 180 : 95)
                .zIndex(5)
            NavigationLink(destination: MeditationGenerator(vm: vm, mode: Shapes(), group: group)) {
                
                Button(action: {
                    
                    let newMessage = Message(id: UUID(), role: .user, content: item.name, createAt: Date())
                    
                    viewModel.messages.append(newMessage)
                }, label: {
                    ZStack {
                        
                        HStack {
                            Spacer()
                            if savedButtonExpand {
                                Button(action: {
                                
                                        viewModel.counter -= 1
                                    if let newItem = item.thaw(),
                                       let realm = newItem.realm {
                                        
                                        try? realm.write {
                                            realm.delete(newItem)
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "trash")
                                        .fontWeight(.thin)

                                        .foregroundColor(Color("homeBrew"))
                                })
                                .buttonStyle(.borderless)
                            }
                            Spacer()
                                .frame(width:0)
                            Text(savedButtonExpand ? item.name : "Saved Meditation #\(item.savedId)")
                                .font(.system(size: 20))
                                .fontWeight(.thin)
                                .foregroundColor(Color("homeBrew"))
                                .frame(width: 200)
                            Spacer()
                                .frame(width: 0)
                            Button(action: {
                                withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                    
                                    savedButtonExpand.toggle()

                                }

                            }, label: {
                                Image(systemName: savedButtonExpand ? "minus.circle" : "i.circle")
                                    .fontWeight(.thin)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("homeBrew"))
                            })
                            .buttonStyle(.borderless)
                            Spacer()
                                .frame(width: 15)
                                
                            
                        }
                    }
                }
                )
                .buttonStyle(.borderless)
                .frame(width: 275, height: savedButtonExpand ? 150 : 65)
                .modifier(Shapes.NeumorphicRectangle(mode: mode))
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                
             
            }
        }
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        let group = BackendGroup()

        MainMeditation(mode: Shapes(), group: group)
    }
}
