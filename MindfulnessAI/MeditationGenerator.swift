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

    var body: some View {

    NavigationView {
        ScrollView {
            HStack {
                NavigationLink(destination: ChatView(vm: vm), label:  {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(cvm.homeBrew)
                    
                })
                .buttonStyle(.borderless)
                .frame(width: 60, height: 40)
                .modifier(Shapes.NeumorphicPopedOutBox())
                .padding(.trailing, 320)
            }
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350, height: 460)
                    .foregroundColor(cvm.offBlack)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                
                VStack {
                    Text("generate a meditation")
                        .foregroundColor(cvm.homeBrew)
                        .frame(width: 250, height: 70)
                        .modifier(Shapes.NeumorphicBox())
                    
                    
                    ZStack {
                        // text container background
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
                                //.position(x: 167, y: 77)

                                HStack {
                                    
                                    Text("Generate a lesson by pressing the         button.")
                                        .frame(width: 280, height: 60)
                                    Spacer(minLength: 20)
                                }
                                    }
                                    // The text that is generated for the lesions
                                    ForEach(viewModel.meditationInit.filter({$0.role != .system}),
                                            id: \.id) { meditationInit in
                                        messageView(message: meditationInit)
                                        
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
                            
                            VStack {
                                Spacer(minLength: 50)
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
            .zIndex(6)
            Spacer(minLength: 30)
                .onAppear {
                    vm.setup()
                }
            
            HStack(spacing: 40) {
                // meditation play link
                NavigationLink(destination: MainMeditation(vm: vm), label: {
                    Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button
                    
                        .foregroundColor(cvm.homeBrew)
                })
                .buttonStyle(.borderless)
                .frame(width: 150, height: 150)
                // nuemorphic design
                .modifier(Shapes.NeumorphicCircle())
                .zIndex(1)
                
                // generate meditation button
                Button(action: {
                    viewModel.sendMediationMessage()
                    vm.startMeditationPrompt = false
                } ,
                       label: {
                    
                    Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                        .foregroundColor(cvm.homeBrew)
                    
                })
                .buttonStyle(.borderless)
                .frame(width: 150, height: 150)
                
                // nuemorphic design
                .modifier(Shapes.NeumorphicPopedOutBox())
            }
            .scaleEffect(0.9)
            
            Spacer(minLength: 10)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke()
                    .frame(width: 240, height: 70)
                    .foregroundColor(cvm.homeBrew)
                    .zIndex(6)
                
            RoundedRectangle(cornerRadius: 30)
                    .frame(width: 260, height: 80)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                    .foregroundColor(cvm.offBlack)
                HStack {
                    if vm.twentyMinuetButton { //000000
                        Spacer()
                            .frame(width: 15)
                    } else {
                        
                        Spacer()
                            .frame(width: 1)
                    }


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
                    .frame(width:90, height: 50)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                    .zIndex(vm.tenMinuetButton ? 1 : 2)
                    
               } else {
                   Button(action: {
                       vm.tenMinuetButton = false
                   }, label: {
                       Text("10 min")
                           .foregroundColor(Color.gray)
                           .underline(false)
                           .foregroundStyle(cvm.homeBrew)

                   })
                   .buttonStyle(.borderless)
                   .frame(width: 115, height: 70)
                   .modifier(Shapes.NeumorphicBox())

               }
                    if vm.tenMinuetButton || vm.twentyMinuetButton || vm.thirtyMinuetButton {
                        Spacer()
                            .frame(width: 9)
                    } else {
                        
                        Spacer()
                            .frame(width: 20)
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
                    .frame(width:90, height: 50)
                    .modifier(Shapes.NeumorphicPopedOutBox())
                } else {
                    Button(action: {
                        vm.twentyMinuetButton = false
                    }, label: {
                        Text("20 min")
                            .foregroundColor(Color.gray)
                            .underline(false)
                            .foregroundStyle(cvm.homeBrew)

                    })
                    .buttonStyle(.borderless)
                    .frame(width: 115, height: 70)
                    .modifier(Shapes.NeumorphicBox())
                    .zIndex(vm.tenMinuetButton ? 2 : 1)

                }
                    if vm.tenMinuetButton { //000000
                        Spacer()
                            .frame(width: 15)
                    } else {
                        
                        Spacer()
                            .frame(width: 1)
                }
            }
        }
                .frame(minWidth: 600, maxWidth: 600, minHeight: 100, maxHeight: 200)
            
            }
        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.offBlue, cvm.backgroundAppColor]),
            startPoint: .top,
            endPoint: .bottom))

            
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
