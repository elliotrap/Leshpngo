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

    static var shared = Shapes()
    
    @Published var changeMode: Bool = true
    @Published var darkmode: Bool = true

    // nuemorphic design template for the text
    struct NeumorphicBox: ViewModifier {
        
        @ObservedObject var mode = Shapes.shared
        
        @State var radius: CGFloat = 40
        
        func body(content: Content) -> some View {
            content
                .overlay (
                    
                        
                            RoundedRectangle(cornerRadius: radius)
                                .stroke(Color("screenStroke"), lineWidth: 30)
                                .shadow(color: Color("ScreenUpperShadow"), radius: 3, x: mode.changeMode ? 10 : -10, y: mode.changeMode ? 10 : -10)
                                .clipShape(RoundedRectangle(cornerRadius: radius))
                                .shadow(color: Color("screenLowerShadow"), radius: 3, x: mode.changeMode ? -10 : 10, y: mode.changeMode ? -10 : 10)
                                .clipShape(RoundedRectangle(cornerRadius: radius))
                       
                    
                    
                )
            
        }
    }
    
    

    // nuemorphic design template for circle buttons
    struct NeumorphicCircle: ViewModifier {
        
        
        @ObservedObject var mode = Shapes.shared
        
        
        func body(content: Content) -> some View {
            
            
            content
                .background(ZStack {
                    if mode.changeMode {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                        
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
                    } else {
                        
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
                        
                        
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                })
                .cornerRadius(100)
                .shadow(color: Color("shadowBlack"), radius: 20, x: mode.changeMode ? 20 : -20, y: mode.changeMode ? 20 : -20)
                .shadow(color: Color("shadowLight"), radius: 20, x: mode.changeMode ? -20 : 20, y: mode.changeMode ? -20 : 20)
            
            
        }
        
    }
    
    
    struct NeumorphicBackCircle: ViewModifier {
        
        
        @ObservedObject var mode = Shapes.shared

        
        func body(content: Content) -> some View {
            
            
            content
                .background(ZStack {
                    if mode.changeMode {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                        
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
                     
                    } else {
                        
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
                        
                        
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    }
                })
                .cornerRadius(100)
                .shadow(color: Color("backButtonShadowBlack"), radius: 5, x: mode.changeMode ? 10 : -10, y: mode.changeMode ? 10 : -10)
                .shadow(color: Color("shadowLight"), radius: 5, x: mode.changeMode ? -10 : 10, y: mode.changeMode ? -10 : 10)

            
            
        }
        
        
    }
    
    // nuemorphic design template for circle buttons
    struct NeumorphicCirclePushedIn: ViewModifier {
        
        
        @ObservedObject var mode = Shapes.shared

        
        
        func body(content: Content) -> some View {
            content
                .background(
                    ZStack {
                        if mode.changeMode {
                        
                                Circle()
                                    .fill(LinearGradient(colors: [Color("offBlue"), Color("offBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 8)
                                            .blur(radius: 5)
                                            .offset(x: -4, y: -4)
                                            .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                                        
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(Color("circleShadowUpper"), lineWidth: 6)
                                            .blur(radius: 5)
                                            .offset(x: 5, y: 5)
                                            .mask(Circle().fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                            
                                
                            } else {
                                Circle()
                                    .fill(LinearGradient(colors: [Color("offBlue"), Color("offBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 8)
                                            .blur(radius: 5)
                                            .offset(x: -4, y: -4)
                                            .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                                        
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(Color("circleShadowBlack"), lineWidth: 6)
                                            .blur(radius: 5)
                                            .offset(x: 5, y: 5)
                                            .mask(Circle().fill(LinearGradient(Color("circleShadowBlack"), Color.black))))
                            }
                        }
                )
        }
    }
    
    // nuemorphic design template for circle buttons
    struct NeumorphicCirclePushedInMain: ViewModifier {
        
        
        @ObservedObject var mode = Shapes.shared

        
        
        func body(content: Content) -> some View {
            content
                
                    
                    
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
    }
    
    
    // nuemorphic design template for the boxes of buttons
    struct NeumorphicPopedOutBox: ViewModifier {
        
        @ObservedObject var mode = Shapes.shared

        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
                    if mode.changeMode {
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
                        
                        
                    } else {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    }
                })
                .cornerRadius(30)
                .shadow(color: Color("shadowBlack"), radius: 20, x: mode.changeMode ? 20 : -20, y:mode.changeMode ? 20 : -20)
                .shadow(color: Color("shadowLight"), radius: 20, x: mode.changeMode ? -20 : 20, y: mode.changeMode ? -20 : 20)
        }
    }
    struct NeumorphicMenuPopedOutBox: ViewModifier {
        
        @ObservedObject var mode = Shapes.shared

        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
                    if mode.changeMode {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                        
                    } else {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    }
                })
                .cornerRadius(30)
                .shadow(color: Color("mediumSizedShadowBlack"), radius: 10, x: mode.changeMode ? 10 : -10, y: mode.changeMode ? 10 : -10)
                .shadow(color: Color("shadowLight"), radius: 10, x: mode.changeMode ? -10 : 10, y: mode.changeMode ? -10 : 10)
        }
    }
   
    struct NeumorphicPopedOutBackBox: ViewModifier {
        
        @ObservedObject var mode = Shapes.shared

        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
        
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 15)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 50)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    
                })
                .cornerRadius(30)
                .shadow(color: Color("shadowBlack"), radius: 30, x: -20, y: -20)
                .shadow(color: Color("shadowLight"), radius: 30, x:  20, y:  20)
        }
    }
    struct backAndForthButton: ViewModifier {
        
        @ObservedObject var mode = Shapes.shared

        
        func body(content: Content) -> some View {
            content
                .background(ZStack {
                    if mode.changeMode {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                        
                    } else {
                        Color("shadowBlack")
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("offBlue"))
                            .blur(radius: 10)
                            .offset(x: 8, y: 8)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    }
                })
                .cornerRadius(30)
                .shadow(color: Color("backAndForthShadowBlack"), radius: 5, x: mode.changeMode ? 10 : -10, y:mode.changeMode ? 10 : -10)
                .shadow(color: Color("shadowLight"), radius: 5, x: mode.changeMode ? -10 : 10, y: mode.changeMode ? -10 : 10)
        }
    }
    
    
    // nuemorphic design template for the boxes of buttons
    struct NeumorphicClickedBox: ViewModifier {
        
        
        @ObservedObject var mode = Shapes.shared

        func body(content: Content) -> some View {
            content
                .overlay( ZStack {
                    if mode.changeMode {
                    
                            RoundedRectangle(cornerRadius: 30)
                                .fill(LinearGradient(colors: [Color("leftCircleShadowWhite"), Color("rightCircleShadowBlack")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowUpper"), lineWidth: 20)
                                        .blur(radius: 4)
                                        .offset(x: -4, y: -4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.black, Color.clear)))
                                    
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowLower"), lineWidth: 11)
                                        .blur(radius: 7)
                                        .offset(x: 4, y: 4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color("circleShadowUpper"), Color.black)))
                                )
                          

                        
                    } else {
                    
                            RoundedRectangle(cornerRadius: 30)
                                .fill(LinearGradient(colors: [Color("rightCircleShadowBlack"), Color("leftCircleShadowWhite")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowBlack"), lineWidth: 6)
                                        .blur(radius: 5)
                                        .offset(x: 4, y: 4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.black, Color.clear)))
                                    
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("circleShadowLower"), lineWidth: 6)
                                        .blur(radius: 5)
                                        .offset(x: -4, y:  -4)
                                        .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color("circleShadowBlack"), Color.black)))
                                )
                            
                        
                        
                    }
                }
                          
                )
        }
    }
    
    
    
    
    
    // nuemorphic design template for the rectangle buttons
    struct NeumorphicRectangle: ViewModifier {
        
        @ObservedObject var mode = Shapes.shared

        
        @ObservedObject var vm = ViewModel()
        func body(content: Content) -> some View {
            content
            
                .background(
                    ZStack {
                        if mode.changeMode {
                            
                            Color("shadowBlack")
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(Color("offBlue"))
                                .blur(radius: 10)
                                .offset(x: -8, y: -8)
                            
                            RoundedRectangle(cornerRadius: 30)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                                )
                                .padding(2)
                                .blur(radius: 2)
                            
                            
            
                            
                            } else {
                                Color("shadowBlack")
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(Color("offBlue"))
                                    .blur(radius: 10)
                                    .offset(x: 8, y: 8)
                                
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                                    )
                                    .padding(2)
                                    .blur(radius: 2)
                            
                            }
                      
                        
                        }
                    )
            
                .cornerRadius(30)
                .shadow(color: Color("shadowBlack"), radius: 20, x: mode.changeMode ? 20 : -20, y:mode.changeMode ? 20 : -20)
                .shadow(color: Color("shadowLight"), radius: 20, x: mode.changeMode ? -20 : 20, y: mode.changeMode ? -20 : 20)

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
    
    struct SpinningModifier: ViewModifier {
        @State var isAnimating: Bool = false
        
        @ObservedObject var mode = Shapes.shared

        
        @ObservedObject var vm = ViewModel()
        func body(content: Content) -> some View {
            content
                        .background(ZStack {
                            if mode.changeMode {
                                Color("shadowBlack")
                                RoundedRectangle(cornerRadius: 100)
                                    .foregroundColor(Color("offBlue"))
                                    .blur(radius: 10)
                                    .offset(x: 8, y: 8)
                                
                                
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                                    )
                                    .padding(2)
                                    .blur(radius: 2)
                                
                                
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
                            } else {
                                
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
                                
                                
                                Color("shadowBlack")
                                RoundedRectangle(cornerRadius: 100)
                                    .foregroundColor(Color("offBlue"))
                                    .blur(radius: 10)
                                    .offset(x: 8, y: 8)
                                
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color("offBlue"), Color("offBlack")]), startPoint: .bottomTrailing, endPoint: .topLeading)
                                    )
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                        })
                        .cornerRadius(100)
                        .shadow(color: Color("shadowBlack"), radius: 20, x: mode.changeMode ? 20 : -20, y: mode.changeMode ? 20 : -20)
                        .shadow(color: Color("shadowLight"), radius: 20, x: mode.changeMode ? -20 : 20, y: mode.changeMode ? -20 : 20)
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                isAnimating = true
                            }
                        }
                    
                }
                
            }

        
    
    
    

    struct FlickeringBinaryBackground: ViewModifier {
        @State private var randomText = ""
        let characters = ["0", "1"]

        func body(content: Content) -> some View {
            content
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .foregroundColor(.clear)
                    .frame(width: 320, height: 80)
                    .modifier(Shapes.NeumorphicCircle())
//                 Flickering binary background
                Text(randomText)
                    .cornerRadius(100)
                    .frame(width: 310, height: 70)
                    .font(.system(size: 8.35))
                    .lineLimit(nil)
                    .foregroundColor(Color("homeBrewSelect")) // Adjust the color accordingly
                    .onAppear {
                        startFlickeringEffect()
                    }
              
                    .zIndex(4)

                // Name of the app
                Text("Léshpngo")
                    .font(.system(size: 52))
                    .foregroundColor(Color("logoColor"))
                    .zIndex(5)
            }
        }

        private func startFlickeringEffect() {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                randomText = (0..<750).map { _ in characters.randomElement() ?? "0" }.joined()
            }
        }
    }


    
    
}
