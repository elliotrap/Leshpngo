//
//  File.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 5/10/23.
//

import SwiftUI
import Foundation


extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

class Shapes: ObservableObject {
    
    @Published var changeMode: Bool = true
    
    // nuemorphic design template for the text
    struct NeumorphicBox: ViewModifier {
        
        
        @State var radius: CGFloat = 40
        
        func body(content: Content) -> some View {
            content
                .overlay (
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(Color("offBlack"), lineWidth: 30)
                            .shadow(color: Color("blackScreen"), radius: 3, x: 10, y: 10)
                            .clipShape(RoundedRectangle(cornerRadius: radius))
                            .shadow(color: Color("offBlue"), radius: 3, x: -5, y: -5)
                            .clipShape(RoundedRectangle(cornerRadius: radius))
                    
                )
            
        }
    }
    

    
    // nuemorphic design template for circle buttons
    struct NeumorphicCircle: ViewModifier {
        
        
        @ObservedObject var shadow = Shapes()
        
        
        
        func body(content: Content) -> some View {
            
            
            content
                    .background(ZStack {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: -8, y: -8)
                           
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                           

                        
                    })
                    .cornerRadius(100)
                    .shadow(color: Color("shadowBlack"), radius: 20, x: 20, y: 20)
                    .shadow(color: Color("offBlue"), radius: 20, x: -20, y: -20)


        }
        
    }
        
        // nuemorphic design template for circle buttons
        struct NeumorphicCirclePushedIn: ViewModifier {
            
            
            @ObservedObject var shadow = Shapes()
            
        
            
            func body(content: Content) -> some View {
                content
                .background(
          
                    Group {
                        Circle()
                            .fill(LinearGradient(colors: [Color("offBlue"), Color("offBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 8)
                                    .blur(radius: 5)
                                    .offset(x: 4, y: 4)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                                
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color("circleShadowBlack"), lineWidth: 6)
                                    .blur(radius: 5)
                                    .offset(x: -5, y: -5)
                                    .mask(Circle().fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                        
                    }
                )
            }
        }
    
    // nuemorphic design template for circle buttons
    struct NeumorphicCirclePushedInMain: ViewModifier {
        
        
        @ObservedObject var shadow = Shapes()
        
    
        
        func body(content: Content) -> some View {
            content
            .background(
      
                Group {
                    Circle()
                        .fill(LinearGradient(colors: [Color("lowerCircleShadowWhite"), Color("upperCircleShadowBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 12)
                                .blur(radius: 5)
                                .offset(x: 4, y: 4)
                                .mask(Circle().fill(LinearGradient(Color("blackCircleShadow"), Color.clear)))
                            
                        )
                        .overlay(
                            Circle()
                                .stroke(Color("circleShadowBlack"), lineWidth: 6)
                                .blur(radius: 5)
                                .offset(x: -4, y: -4)
                                .mask(Circle().fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                    
                }
            )
        }
    }

    
    // nuemorphic design template for the boxes of buttons
    struct NeumorphicPopedOutBox: ViewModifier {
        
        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
                    Color("shadowBlack")
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color("offBlue"))
                        .blur(radius: 10)
                        .offset(x: -8, y: -8)
                       
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        )
                        .padding(2)
                        .blur(radius: 2)
                       

                    
                })
                .cornerRadius(30)
                .shadow(color: Color("shadowBlack"), radius: 20, x: 20, y: 20)
                .shadow(color: Color("offBlue"), radius: 20, x: -20, y: -20)
        }
    }
    
    // nuemorphic design template for the boxes of buttons
    struct NeumorphicClickedBox: ViewModifier {
        
        
        @ObservedObject var mode: Shapes
        
        func body(content: Content) -> some View {
            content
                .overlay( ZStack {
                    if mode.changeMode {
                        Group {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(LinearGradient(colors: [Color("leftCircleShadowWhite"), Color("rightCircleShadowBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowBlack"), lineWidth: 12)
                                        .blur(radius: 5)
                                        .offset(x: 4, y: 4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.black, Color.clear)))
                                    
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowLower"), lineWidth: 6)
                                        .blur(radius: 5)
                                        .offset(x: -4, y: -4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                            
                        }
                    } else {
                        Group {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(LinearGradient(colors: [Color("leftCircleShadowWhite"), Color("rightCircleShadowBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowBlack"), lineWidth: 12)
                                        .blur(radius: 5)
                                        .offset(x: -4, y: -4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.black, Color.clear)))
                                    
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowLower"), lineWidth: 6)
                                        .blur(radius: 5)
                                        .offset(x: 4, y:  4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                            
                        }

                    }
                }
                
            )
        }
    }
    
    struct NeumorphicClickedBoxLight: ViewModifier {
        
        
        @ObservedObject var mode = Shapes()
        
        func body(content: Content) -> some View {
            content
                .overlay( ZStack {
                    
                    Group {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(colors: [Color("leftCircleShadowWhite"), Color("rightCircleShadowBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color("circleShadowBlack"), lineWidth: 12)
                                    .blur(radius: 5)
                                    .offset(x: -4, y: -4)
                                    .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.black, Color.clear)))
                                
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color("circleShadowLower"), lineWidth: 6)
                                    .blur(radius: 5)
                                    .offset(x:  -40, y: mode.changeMode ? 4 : -4)
                                    .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                        
                    }
                }
                
            )
        }
    }
    
    // nuemorphic design template for the rectangle buttons
    struct NeumorphicRectangle: ViewModifier {
        
        
        @ObservedObject var vm = ViewModel()
        func body(content: Content) -> some View {
            content
            
                .background(ZStack {
                    Color("shadowBlack")
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("offBlue"))
                        .blur(radius: 10)
                        .offset(x: -8, y: -8)
                 
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        )
                        .padding(2)
                        .blur(radius: 2)
                       
                })
                .cornerRadius(20)
                .shadow(color: Color("shadowBlack"), radius: 20, x: 20, y: 20)
                .shadow(color: Color("offBlue"), radius: 20, x: -20, y: -20)
        }
    }
    
    // nuemorphic design template for the slider
    struct NeumorphicSider: ViewModifier {
            
            
            func body(content: Content) -> some View {
                content
                    .background(ZStack {
                        Color("shadowBlackSlider")
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color("offGreenSlider"))
                            .blur(radius: 6)
                            .offset(x: -5, y: -5)
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offHomeBrewSlider"), Color("offGreenSlider")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                            )
                            .padding(1.7)
                            .blur(radius: 1.7)
                        
                    })
                    .cornerRadius(100)
        }
    }
}
