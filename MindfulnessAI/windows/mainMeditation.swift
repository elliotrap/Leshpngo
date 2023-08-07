//
//  mainMeditation.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/28/23.
//

import Foundation
import SwiftUI
import AVFoundation

struct MainMeditation: View {
    
    @ObservedObject var vm = ViewModel()
    
    @ObservedObject var cvm = ColorViewModel()
    
    @State var playPause = true
    
    @State var goBackward = true
    
    @State var goForward = true
    
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
                        Text("Léshpngo")
                            .foregroundColor(cvm.homeBrew)
                            .frame(width: 160, height: 70)
                            .modifier(Shapes.NeumorphicBox())
                        
                        
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
                                    Spacer()
                                        .frame(height: 70)
                                    ScrollView {
                         
                                        
                                        
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
                    .scaleEffect(0.9)

                }
                .zIndex(6)
                
                Spacer()
                    .frame(height: 25)
                ZStack {
                    // green background
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1.5)
                        .frame(width: 344, height: 62)
                        .foregroundColor(cvm.homeBrew)
                    
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(cvm.offBlack)
                        .modifier(Shapes.NeumorphicBox())
                        .frame(width: 330, height: 60)
                    
                    ZStack(alignment: .leading, content: {
                        // slider itself make the slider have neumorphism
                        HStack {
                            Spacer()
                                .frame(width: 35)
                            Circle()
                                .foregroundColor(Color.clear)
                                .frame(width: vm.sliderHeight, height: 13)
                                .modifier(Shapes.NeumorphicSider())
                                .zIndex(6)
                        }
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color.clear)
                            .frame(width: 330, height: 60)
                        
                        
                    })
                    .frame(width: vm.maxHeight)
                    // the logic for the slider
                    .gesture(DragGesture(minimumDistance:
                                            0).onChanged({ (value) in
                        
                        let translation = value.translation
                        
                        vm.sliderHeight = translation.width + vm.lastDragValue
                        
                        vm.sliderHeight = vm.sliderHeight > vm.maxHeight ? vm.maxHeight : vm.sliderHeight
                        
                        vm.sliderHeight = vm.sliderHeight >= 0 ?
                        vm.sliderHeight : 0
                        vm.sliderProgress += 5
                        
                        
                    }) .onEnded({ (value) in
                        
                        vm.sliderHeight = vm.sliderHeight > vm.maxHeight ? vm.maxHeight : vm.sliderHeight
                        
                        vm.sliderHeight = vm.sliderHeight >= 0 ?
                        vm.sliderHeight : 0
                        
                        vm.lastDragValue = vm.sliderHeight
                        vm.lessonSliderHeight = vm.lessonSliderHeight
                        
                    }))
                }
                .scaleEffect(0.9)

                Spacer()
                    .frame(height: 30)
                HStack(spacing: 30) {
                    
                    // move backward 15 seconds button
                    if goBackward {
                        // play button
                        Button(action: {
                            goBackward = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                goBackward = true
                            }
                            
                        }, label: {
                            Image(systemName: "gobackward.15") .resizable() .frame(width: 40, height: 40)
                                .foregroundColor(cvm.homeBrew)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 80, height: 80)
                        
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCircle())
                    } else {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "gobackward.15") .resizable() .frame(width: 40, height: 40)
                                .foregroundColor(Color.gray)

                        })
                        .buttonStyle(.borderless)
                        .frame(width: 80, height: 80)
                        
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCirclePushedInMain())
                    }
                    
                    if playPause {
                        // play button
                        Button(action: {
                            playPause = false
                        }, label: {
                            Image(systemName: "play.fill") .resizable() .frame(width: 40, height: 40)
                                .foregroundColor(cvm.homeBrew)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 100, height: 100)
                        
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCircle())
                    } else {
                        Button(action: {
                            playPause = true
                        }, label: {
                            Image(systemName: "pause.fill") .resizable() .frame(width: 40, height: 40)
                                .foregroundColor(cvm.homeBrew)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 100, height: 100)
                        
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCirclePushedInMain())
                    }
                    
                    
                    // move forward 15 seconds button
                    if goForward {
                        // play button
                        Button(action: {
                            goForward = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                goForward = true
                            }
                            
                        }, label: {
                            Image(systemName: "gobackward.15") .resizable() .frame(width: 40, height: 40)
                                .foregroundColor(cvm.homeBrew)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 80, height: 80)
                        
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCircle())
                    } else {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "gobackward.15") .resizable() .frame(width: 40, height: 40)
                                .foregroundColor(Color.gray)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 80, height: 80)
                        
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCirclePushedInMain())
                    }
                }
                
                
                VStack {
                    Spacer(minLength: 350)
                    
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
struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        MainMeditation()
    }
}


