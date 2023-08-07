//
//  ContentView.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/16/23.
//

import Foundation
import SwiftUI
import AVFoundation



struct MeditationGenerator: View {
    
    @ObservedObject var viewModel = MeditationViewModel()

    @ObservedObject var vm = ViewModel()
    
    @ObservedObject var cvm = ColorViewModel()
    
    @ObservedObject var shapeVm = Shapes()

    @State var playingMain = true
    @State var pressedResetMain = true
    
    var body: some View {

    NavigationView {
        ScrollView(showsIndicators: false) {
            HStack {
                NavigationLink(destination: ChatView(vm: vm), label:  {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(cvm.homeBrew)
                    
                })
                .buttonStyle(.borderless)
                .frame(width: 60, height: 40)
                .modifier(Shapes.NeumorphicPopedOutBox())
                .padding(.trailing, 280)
            }
    
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350, height: 460)
                    .foregroundColor(cvm.offBlack)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                
                VStack {
                        RoundedRectangle(cornerRadius: 30)
                        .frame(width: 210, height: 60)
                        .modifier(Shapes.NeumorphicClickedBox())
                        .overlay(
                            Text("Choose a Meditation")
                                .foregroundColor(cvm.homeBrew)
                        )
                        
                    
                    
                    ZStack {
                        // green text container background
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .frame(width: 355, height: 400)
                            .foregroundColor(cvm.homeBrew)
                            .zIndex(3)
                        
                        // layout
                        ZStack {
                            VStack {
                                ScrollView {
                                    if vm.startMeditationPrompt {
                                        Image(systemName: "arrow.2.squarepath")
                               .position(x: 67, y: 65)
                               // .position(x: 167, y: 77)

                                HStack {
                                    
                                    Text("Generate a lesson by pressing the         button.")
                                        .frame(width: 280, height: 60)
                                    Spacer(minLength: 20)
                                }
                                    }
                                    // The text that is generated for the lesions
                                    ForEach(viewModel.meditationInit.filter({$0.role != .system}),
                                            id: \.id) { lessonMessage in
                                        messageView(message: lessonMessage)
                                        
                                    }
                                            .position(x:140, y: 170)
                                            .frame(width: 280, height: 400)
                                }
                            }
                            .foregroundColor(cvm.homeBrew)
                            .frame(width: 290, height: 370)
                            .zIndex(5)
                            
                            // the progression of the 1's and 0's that iterate the index to make an animation
                            if vm.isLoading == true {
                                Text(vm.prompts[vm.promptIndex])
                                    .position(x:180, y: 200)
                                    .frame(width: 355, height: 400)
                                    .font(.system(size:15))
                                    .foregroundColor(cvm.homeBrew)
                                    .zIndex(4)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                                            if vm.promptIndex == vm.prompts.count - 1 {
                                                vm.promptIndex = 0
                                            } else {
                                                vm.promptIndex += 1
                                            }
                                        }
                                    }
                            }
                            
                            if vm.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: cvm.homeBrew))
                                    .position(x: 415, y: 365)
                                    .zIndex(5)
                                
                            }
                            
    
                            
                            RoundedRectangle(cornerRadius: 50)
                                .fill(cvm.offBlack)
                                .frame(width: 350, height: 400)
                                .modifier(Shapes.NeumorphicBox())
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
                        playingMain.toggle()
                    }, label: {
                        Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button
                            .foregroundColor(cvm.homeBrew)
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCircle())
                    .zIndex(4)
                    
                } else {
                    // lession play button
                    Button(action: {
                        shapeVm.flipShadow.toggle()
                        playingMain.toggle()
                    }, label: {
                        Image(systemName: "pause.circle").resizable().frame(width: 50, height: 50) // play button
                            .foregroundColor(cvm.pauseRed)
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCirclePushedIn())
                    .zIndex(4)
                }
                
                if pressedResetMain {
                    // generate meditation button
                    Button(action: {
                        // viewModel.sendMediationMessage()
                        vm.startMeditationPrompt = false
                        pressedResetMain = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            pressedResetMain = true
                        }
                    },
                           label: {
                        
                        Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                            .foregroundColor(cvm.homeBrew)
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicPopedOutBox())
                } else {
                    Button(action: {
                       // viewModel.sendMediationMessage()
                        vm.startMeditationPrompt = false
                    } ,
                           label: {
                        

                        
                    })
                    .cornerRadius(30)
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicClickedBox())
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
                    .foregroundColor(cvm.homeBrew)
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
                            .foregroundStyle(cvm.homeBrew)
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 130, height: 50)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                    .zIndex(vm.tenMinuetButton ? 1 : 2)
                    
               } else {
                   Button(action: {
                   }, label: {
              

                   })
                   .buttonStyle(.borderless)
                   .frame(width: 130, height: 50)
                   .modifier(Shapes.NeumorphicClickedBox())
                   .zIndex(vm.tenMinuetButton ? 2 : 1)
           
                   .overlay(
                       Text("10 min")
                       .foregroundColor(Color.gray)
                       .underline(false)
                       .foregroundStyle(cvm.homeBrew)
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
                            .foregroundStyle(cvm.homeBrew)
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width:130, height: 50)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                } else {
                    Button(action: {
                    }, label: {
               

                    })
                    .buttonStyle(.borderless)
                    .frame(width: 130, height: 50)
                    .modifier(Shapes.NeumorphicClickedBox())
                    .zIndex(vm.tenMinuetButton ? 2 : 1)
                    .overlay(
                        Text("20 min")
                        .foregroundColor(Color.gray)
                        .underline(false)
                        .foregroundStyle(cvm.homeBrew)
                    )

                }
       
            }
        }
                .frame(minWidth: 600, maxWidth: 600, minHeight: 100, maxHeight: 200)
            
            }
        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.offBlue, cvm.backgroundAppColor]),
            startPoint: .topLeading,
            endPoint: .bottomLeading))

            
        }
        
    }
    func messageView(message: Message) -> some View {
        HStack {
            Text(message.content)
            if message.role == .assistant {Spacer()}
        }
    }
}


struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        MeditationGenerator()        
    }
}
