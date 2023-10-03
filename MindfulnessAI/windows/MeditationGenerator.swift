//
//  ContentView.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/16/23.
//

import Foundation
import SwiftUI
import AVFoundation
import RealmSwift


struct MeditationGenerator: View {


//    @ObservedObject var viewModel = MeditationViewModel()

    @ObservedObject var vm = ViewModel()
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes()
    @ObservedObject var viewModel = ChatViewModel.shared
    @StateObject var realm = LoginLogout()
    @ObservedRealmObject var group: Group
    @ObservedObject var helper = RealmHelper()

    
    let realmConnect = try! Realm()

    @State var playingMain = true
    @State var pressedResetMain = true
    
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
    
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350, height: 530)
                    .foregroundColor(Color("offBlack"))
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                
                VStack {
                   
                        Text("")
                        .frame(width: 210, height: 60)
                        .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                        .overlay(
                            Text("Choose a Meditation")
                                .font(.system(size: 18))
                                .foregroundColor(Color("homeBrew"))
                        )
                   
                    
                    
                    ZStack {
                   
                        // green text container background
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .frame(width: 355, height: 400)
                            .foregroundColor(Color("homeBrew"))
                            .zIndex(3)
                            .padding(.bottom, 30)

                        
                        // layout
                        ZStack {
                            
                            VStack {
                                
                                ScrollView {
                                    if vm.startMeditationPrompt {
                                        Image(systemName: "arrow.2.squarepath")
                               // .position(x: 67, y: 65)
                               .position(x: 167, y: 77)

                                HStack {
                                    
                                    Text("Generate a lesson by pressing the         button.")
                                        .frame(width: 280, height: 60)
                                    Spacer(minLength: 20)
                                }
                                    }
                                    // The text that is generated for the lesions
                                    if let firstMessage = viewModel.messages.last(where: { $0.role != .system }) {
                                        // Create a Text view with the content of the first message
                                        Text(firstMessage.content)
                                            .padding(.top, 30)
                                            .padding(.bottom, 30)
                                    
                                        
                                        
                                    }
                                          
                                }
                            }
                            .foregroundColor(Color("homeBrew"))
                            .frame(width: 290, height: 370)
                            .zIndex(5)
                            
                            
                            if vm.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color("homeBrew")))
                                    .position(x: 415, y: 365)
                                    .zIndex(5)
                                
                            }
                            
    
                            
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("offBlack"))
                                .frame(width: 350, height: 400)
                                .modifier(Shapes.NeumorphicBox())
                                .padding(.bottom, 30)
                            VStack {
                                Spacer()
                                    .frame(height: 450)
                                
                                Button(action: {
                                    let newItem = Item(name: viewModel.latestAssistantMessage, isFavorite: false)
                                              try? realmConnect.write {
                                                  realmConnect.add(newItem)
                                              }
                                }, label: {
                                    Text("save")
                                        .foregroundColor(Color("homeBrewSelect"))
                                })
                                .frame(width: 100, height: 10)
                            }
                      
                        }
                        
                    }
                }
                .scaleEffect(0.9)

            }
            .scaleEffect(0.9)
            .zIndex(6)
       
                .onAppear {
                    vm.setup()
                }
            
            HStack(spacing: 40) {
                // meditation play link
                if playingMain {
                    
                    // lession play button
                    Button(action: {
            
                        viewModel.textToSpeech(ssmlText: viewModel.latestAssistantMessage)
                   

                        playingMain.toggle()
                    }, label: {
                        Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button
                            .foregroundColor(Color("homeBrew"))
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCircle(mode: mode))
                    .zIndex(4)
                    
                } else {
                    // lession play button
                    Button(action: {
                        playingMain.toggle()
                    }, label: {
                        Image(systemName: "pause.circle").resizable().frame(width: 50, height: 50) // play button
                            .foregroundColor(Color.red)
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCirclePushedIn(mode: mode))
                    .zIndex(4)
                 
                }
                
                if pressedResetMain {
                    // generate meditation button
                    Button(action: {
                        viewModel.sendMessage()
                        vm.startMeditationPrompt = false
                        pressedResetMain = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            pressedResetMain = true
                        }
                    },
                           label: {
                        
                        Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                            .foregroundColor(Color("homeBrew"))
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                } else {
                    Button(action: {
                        viewModel.sendMessage()
                        vm.startMeditationPrompt = false
                    } ,
                           label: {
                        

                        
                    })
                    .cornerRadius(30)
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    .overlay(
                        Image(systemName: "arrow.2.squarepath").resizable().frame(width: 80, height: 70) // reset button
                            .foregroundColor(Color.gray)
                        )
                }
            }
            .scaleEffect(0.9)
            

            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke()
                    .frame(width: 300, height: 70)
                    .foregroundColor(Color("homeBrew"))
                    .zIndex(6)
                
        
                HStack {
        
                    if vm.tenMinuetButton == false {
                    Button(action: {
                        vm.tenMinuetButton = true
                        vm.twentyMinuetButton = false
                    },
                           label: {
                        Text("10 min")
                            .underline(false)
                            .foregroundStyle(Color("homeBrew"))
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 130, height: 50)
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                    .zIndex(vm.tenMinuetButton ? 1 : 2)
                    
               } else {
                   Button(action: {
                   }, label: {
              

                   })
                   .buttonStyle(.borderless)
                   .frame(width: 130, height: 50)
                   .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                   .zIndex(vm.tenMinuetButton ? 2 : 1)
           
                   .overlay(
                       Text("10 min")
                       .foregroundColor(Color.gray)
                       .underline(false)
                       .foregroundStyle(Color("homeBrew"))
                   )
                  

               }
  

                if vm.twentyMinuetButton == false {
                    Button(action: {
                        vm.twentyMinuetButton = true
                        vm.tenMinuetButton = false
                    },
                           label: {
                        Text("20 min")
                            .underline(false)
                            .foregroundStyle(Color("homeBrew"))
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width:130, height: 50)
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                } else {
                    Button(action: {
                    }, label: {
               

                    })
                    .buttonStyle(.borderless)
                    .frame(width: 130, height: 50)
                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    .zIndex(vm.tenMinuetButton ? 2 : 1)
                    .overlay(
                        Text("20 min")
                        .foregroundColor(Color.gray)
                        .underline(false)
                        .foregroundStyle(Color("homeBrew"))
                    )

                }
       
            }
        }
                .frame(minWidth: 600, maxWidth: 600, minHeight: 100, maxHeight: 200)
            
            }
        .background(LinearGradient (
            
            gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading))
        .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)

            
        }
        
    }
}
struct ItemRow: View {
    
    @ObservedRealmObject var item: Item
    @ObservedObject var vm = ViewModel()
    @ObservedRealmObject var group: Group
    @ObservedObject var mode: Shapes
    @ObservedObject var viewModel = ChatViewModel.shared

    
    var body: some View {
        // You can click an item in the list to navigate to an edit details screen.
        NavigationLink(destination: MeditationGenerator(vm: vm, mode: Shapes(), group: group)) {
           
                Button(action: {
                    viewModel.latestAssistantMessage = item.name
                }, label: {
                    ZStack {
                        HStack {
                            Spacer()
                                .frame(width: 10)
                            Text(item.name)
                                .frame(width: 200)
                            Spacer()
                                .frame(width: 10)
                            Button(action: {
                                if let newItem = item.thaw(),
                                   let realm = newItem.realm {
                                    
                                    try? realm.write {
                                        realm.delete(newItem)
                                    }
                                }
                            }, label: {
                                Image(systemName: "trash")
                                    .foregroundColor(Color("homeBrewSelect"))
                            })
                        
                        }
                    }
                }
                )
                .frame(width: 275, height: 65)
                .modifier(Shapes.NeumorphicRectangle(mode: mode))
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                
                if item.isFavorite {
                    // If the user "favorited" the item, display a heart icon
                    Image(systemName: "heart.fill")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let group = Group() // Create an instance of your Group class
        MeditationGenerator(mode: Shapes(), group: group)
    }
}

