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
    
    var body: some View {
        VStack {
            Spacer(minLength: 300)
            
            Text("Leshpngo")
                .frame(width: 220, height: 85)
                .foregroundColor(cvm.homeBrew)
                .font(.system(size: 30))
                .modifier(Shapes.NeumorphicBox())
                
                
            
            ZStack {
                ZStack(alignment: .leading) {
                    
                    ScrollView {
                        // text layout
                        Text(vm.models.first ?? "")
                            .zIndex(1)
                            .frame(width: 280, height: 500, alignment: .leading)
                            .foregroundColor(cvm.homeBrew)
                            .background(cvm.offBlack)
                            .onAppear{
                                vm.aiVoices(vm.models.first ?? "", withPause: 10)
                            }
                    }
                }
                
                
                // clear overlay
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width:500, height: 390)
                .foregroundColor(cvm.homeBrew)
                .frame(width: 290, height: 350)
                .zIndex(5)
                
                // text container
                RoundedRectangle(cornerRadius: 50)
                    .fill(cvm.offBlack)
                    .frame(width: 350, height: 450)
                    .modifier(Shapes.NeumorphicBox())
                    .zIndex(3)
                
                // text container background
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(cvm.homeBrew)
                    .frame(width: 352, height: 452)
                
            }
            .padding(0)
            
            
            
            ZStack {
                ZStack(content: {
                    // slider itself make the slider have neumorphism
                    
                    Circle()
                        .foregroundColor(Color.clear)
                        .frame(width: vm.sliderHeight, height: 13)
                        .modifier(Shapes.NeumorphicSider())
                    
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
                    
                    vm.sliderHeight = -translation.width + vm.lastDragValue
                    
                    vm.sliderHeight = vm.sliderHeight > vm.maxHeight ? vm.maxHeight : vm.sliderHeight
                    
                    vm.sliderHeight = vm.sliderHeight >= 0 ?
                    vm.sliderHeight : 0
                    
                }) .onEnded({ (value) in
                    
                    vm.sliderHeight = vm.sliderHeight > vm.maxHeight ? vm.maxHeight : vm.sliderHeight
                    
                    vm.sliderHeight = vm.sliderHeight >= 0 ?
                    vm.sliderHeight : 0
                    
                    vm.lastDragValue = vm.sliderHeight
                }))
            }
            .padding(10)
        
                Spacer()
                HStack(spacing: 40) {
                    
                    // move backward 15 seconds button
                    Button(action: {
                    }, label: {
                        Image(systemName: "gobackward.15") .resizable() .frame(width: 40, height: 40)
                            .foregroundColor(cvm.homeBrew)
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 80, height: 80)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCircle())
                    
                    // play button
                    Button(action: {
                    }, label: {
                        Image(systemName: "play.fill") .resizable() .frame(width: 40, height: 40)
                            .foregroundColor(cvm.homeBrew)
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 100, height: 100)
                    
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCircle())
                    
                    
                    
                    // move forward 15 seconds button
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "goforward.15") .resizable() .frame(width: 40, height:  40)
                            .foregroundColor(cvm.homeBrew)
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 80, height: 80)
                    .modifier(Shapes.NeumorphicCircle())
                }
                .padding(30)

            

            VStack {
                Spacer(minLength: 350)
                
            }
        }
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 50)
        .background(cvm.offBlack.edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        MainMeditation()
    }
}


