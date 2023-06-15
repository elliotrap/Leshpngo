//
//  File.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 5/10/23.
//

import SwiftUI
import Foundation


class Shapes: ObservableObject {
    
    
    
    
    
    // nuemorphic design template for the text
    struct NeumorphicBox: ViewModifier {
        
        @ObservedObject var cvm = ColorViewModel()
        
        @State var radius: CGFloat = 40
        
        func body(content: Content) -> some View {
            content
                .overlay (
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(cvm.offBlack, lineWidth: 30)
                        .shadow(color: cvm.blackScreen, radius: 3, x: 10, y: 10)
                        .clipShape(RoundedRectangle(cornerRadius: radius))
                        .shadow(color: cvm.offBlue, radius: 3, x: -5, y: -5)
                        .clipShape(RoundedRectangle(cornerRadius: radius))
                        .zIndex(9)
                    
                )
                
        }
        
        
    }
    
    // nuemorphic design template for circle buttons
    struct NeumorphicCircle: ViewModifier {
        
        @ObservedObject var cvm = ColorViewModel()
        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
                    cvm.shadowBlack
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(cvm.offBlue)
                        .blur(radius: 10)
                        .offset(x: -8, y: -8)
                    RoundedRectangle(cornerRadius: 100)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [cvm.offBlue, cvm.offBlack]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        )
                        .padding(2)
                        .blur(radius: 2)
                    
                })
                .cornerRadius(100)
                .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
        }
        
        
    }
    // nuemorphic design template for the boxes of buttons
    struct NeumorphicPopedOutBox: ViewModifier {
        
        @ObservedObject var cvm = ColorViewModel()
        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
                    cvm.shadowBlack
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(cvm.offBlue)
                        .blur(radius: 10)
                        .offset(x: -8, y: -8)
                       
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [cvm.offBlue, cvm.offBlack]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        )
                        .padding(2)
                        .blur(radius: 2)
                       

                    
                })
                .cornerRadius(30)
                .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
        }
    }
    // nuemorphic design template for the rectangle buttons
    struct NeumorphicRectangle: ViewModifier {
        
        @ObservedObject var cvm = ColorViewModel()
        
        @ObservedObject var vm = ViewModel()
        func body(content: Content) -> some View {
            content
            
                .background(ZStack {
                    cvm.shadowBlack
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(cvm.offBlue)
                        .blur(radius: 10)
                        .offset(x: -8, y: -8)
                 
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [cvm.offBlue, cvm.offBlack]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        )
                        .padding(2)
                        .blur(radius: 2)
                       
                })
                .cornerRadius(20)
                .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
        }
    }
    
    // nuemorphic design template for the slider
    struct NeumorphicSider: ViewModifier {
            
            @ObservedObject var cvm = ColorViewModel()
            
            func body(content: Content) -> some View {
                content
                    .background(ZStack {
                        cvm.shadowBlackSlider
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(cvm.offGreenSlider)
                            .blur(radius: 6)
                            .offset(x: -5, y: -5)
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [cvm.offHomeBrewSlider, cvm.offGreenSlider]), startPoint: .topTrailing, endPoint: .bottomLeading)
                            )
                            .padding(1.7)
                            .blur(radius: 1.7)
                        
                    })
                    .cornerRadius(100)
          
            }
            
            
        }
    

    


    
}
