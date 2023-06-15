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
    
    @ObservedObject var vm = ViewModel()
    @ObservedObject var cvm = ColorViewModel()

    var body: some View {
        

        
    NavigationView {
        ScrollView {
            
            HStack {
                NavigationLink(destination: FirstView(vm: vm), label:  {
                    
                    Image(systemName: "arrow.backward")
                        .foregroundColor(cvm.homeBrew)
                    
                })
                .frame(width: 60, height: 40)
                .modifier(Shapes.NeumorphicPopedOutBox())
                .padding(.trailing, 320)
            }
            
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
                                    // The text that is generated for the lesions
                                    Text(vm.models.first ?? "")
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
                       vm.generatePrompt()
                        
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

                ZStack {
    
      
                    
                    
                    HStack {
                        Text("Tokens:")
                            .frame(height: 80)
                            .foregroundColor(cvm.homeBrew)
                            .padding(.leading, 40)
                        
                        Text (
                            String(format: "%.0f", vm.sliderProgress)
                            
                        )
                       
                        .padding(.trailing, 40)
                        .foregroundColor(cvm.homeBrew)

                    }
                    .modifier(Shapes.NeumorphicBox())
                    
                    
                }
                .scaleEffect(0.9)

                ZStack {
                    ZStack(alignment: .leading, content: {
                        // slider itself make the slider have neumorphism
                        
                   
                        HStack {
                           
                            Circle()
                                .foregroundColor(Color.clear)
                                .frame(width: vm.sliderHeight, height: 13)
                                .modifier(Shapes.NeumorphicSider())
                            
                        }
                        .zIndex(6)

                            // Slider body
                            RoundedRectangle(cornerRadius: 100)
                                .foregroundColor(cvm.offBlack)
                                .modifier(Shapes.NeumorphicBox())
                                .frame(width: 330, height: 60)
                            
                            // green background
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(lineWidth: 1.5)
                                .frame(width: 344, height: 62)
                                .foregroundColor(cvm.homeBrew)
                        
                    })
                    
                    .frame(width: vm.maxHeight)
                    // the logic for the slider
                    .gesture(DragGesture(minimumDistance:
                                            0).onChanged({ (value) in
                        
                        let translation = value.translation
                        
                        vm.sliderHeight = translation.width + vm.lastDragValue
                        
                        vm.sliderHeight = vm.sliderHeight > vm.maxHeight ? vm.maxHeight : vm.sliderHeight
                        
                        vm.sliderHeight = vm.sliderHeight >= 0 ? vm.sliderHeight : 0
                        vm.sliderProgress += 5
                        
                        
     
                        
                    }) .onEnded({ (value) in
                        
                        vm.sliderHeight = vm.sliderHeight > vm.maxHeight ? vm.maxHeight : vm.sliderHeight
                        
                        vm.sliderHeight = vm.sliderHeight >= 0 ?
                        vm.sliderHeight : 0
                        
                        vm.lastDragValue = vm.sliderHeight
                        vm.sliderHeight = vm.sliderHeight
                    }))
                }
                .scaleEffect(0.9)

                HStack {
                    // meditation time counter
                    Text("DAYS")
                        .font(.system(size: 13))
                        .foregroundColor(cvm.homeBrew)
                        .position(x: 160, y: 700)
                    
                    
                    Text("HOURS")
                        .font(.system(size: 13))
                        .foregroundColor(cvm.homeBrew)
                        .position(x: 100, y: 700)
                    
                    Text("SESSIONS")
                        .font(.system(size: 13))
                        .foregroundColor(cvm.homeBrew)
                        .position(x: 30, y: 700)
                 
                }
              
                
                .frame(minWidth: 600, maxWidth: 600, minHeight: 0, maxHeight: 0)
            
            }
        .background(LinearGradient (
            
            gradient: Gradient(colors: [cvm.offBlue, cvm.backgroundAppColor]),
            startPoint: .top,
            endPoint: .bottom))

            
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        MeditationGenerator()        
    }
}
