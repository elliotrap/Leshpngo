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
    
    @ObservedObject var vm = viewModel()
    
    @ObservedObject var cvm = ColorViewModel()


    
    var body: some View {
        
        
       
        ZStack {
            
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.gray, lineWidth: 4)
                .blur(radius: 10)
                .offset(x: 2, y: 2)
                .mask(RoundedRectangle(cornerRadius: 50).fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing)))
                .frame(width: 340, height: 500)
                .position(x: 250, y: 300)
                .foregroundColor(cvm.blackScreen)
            
            RoundedRectangle(cornerRadius: 50)
                .stroke(cvm.offBlue, lineWidth: 8)
                .blur(radius: 20)
                .offset(x: -2, y: -2)
                .mask(RoundedRectangle(cornerRadius: 50).fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .bottomTrailing, endPoint: .topLeading)))
                .frame(width: 340, height: 500)
                .position(x: 250, y: 300)
                .foregroundColor(cvm.blackScreen)
                
                
                
            

            
            Image(systemName: "leaf")
                .resizable()
                .frame(width: 30, height: 30)
                .position(x: 230, y: 70)
                .foregroundColor(cvm.homeBrew)
            
            
            
            
            
            ZStack(alignment: .bottom, content: {
                
                
                
                // status bar for audio
                
                Rectangle()
                    .cornerRadius(50)
                    .frame(width: 343, height: 23)
                    .foregroundColor(Color.black)
                    .blur(radius: 4)
                    .offset(x: -0.5, y: -0.5)
                    .position(x:171, y: 650)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(gradient:  Gradient(colors: [cvm.offBlack, cvm.offBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .position(x: 165, y: -30)
                    .frame(width: 340, height: 23)
                    .shadow(color: Color.black, radius: 20, x: 20, y: 20)
                    .shadow(color: cvm.offBlue, radius: 20, x: -30, y: -20)
                    .position(x:171, y: 680)
                
                Rectangle()
                    .cornerRadius(50)
                    .position(x: 177.5, y: -190.5)
                    .foregroundColor(cvm.homeBrew)
                    .frame(width: vm.sliderHeight, height: 10)
            })
            .frame(width: vm.maxHeight)
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
                
                .frame(minWidth: 500, maxWidth: .infinity)
                .background(cvm.offBlack)
    }
}



struct ContentView_Previews2: PreviewProvider {

    static var previews: some View {
        MainMeditation()

    }
}


