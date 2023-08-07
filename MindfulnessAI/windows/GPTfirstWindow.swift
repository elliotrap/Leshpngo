//
//  GPTfirstWindow.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 4/18/23.
//

import Foundation
import SwiftUI

extension UINavigationController {

    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 107 / 255, green: 214 / 255, blue: 110 / 255, alpha: 1.0)
       navigationItem.hidesBackButton = true
    }
}

struct ChatView: View {
    
    @ObservedObject var viewModel = ChatViewModel()
    
    @ObservedObject var vm = ViewModel()
    
    @ObservedObject var cvm = ColorViewModel()
    
    @ObservedObject var shapeVm = Shapes()
    
    @State var playing = true
    
    @State var pressedReset = true
    
    @State var startMeditation = true
    
    @State var gridSpacing: CGFloat = 10

    @State var vipassanaButtonPressed = true
    @State var expand: Bool = false
    @State var promptToggle: Bool = false
    
    @State var metaButtonPressed = false
    @State var expandTwo: Bool = false
    @State var promptToggleTwo: Bool = false
    
    @State var timerButtonPressed: Bool = false
    @State var expandThree: Bool = false
    
    @State var profileButtonPressed = false
    @State var chosenMeditation = "Vipas"
    @State var chosenInstructor = "Chief"
    
    @State var meditationTimeBoxAnimation = false
    @State var meditationTimeBoxExpand = false
    @State var menuPopUp = false
    @State var menuAnimationSizeChange = false
    
    @State var chiefButtonPressed: Bool = true
    @State var chiefButton: Bool = false
    @State var chiefButtonSize: CGFloat = 120
    @State var chiefButtonIconSize: CGFloat = 15
    @State var chiefButtonBackgroundSize: CGFloat = 150
    @State var chiefButtonCornerSize: CGFloat = 30
    
    @State var lunaButtonPressed: Bool = false
    @State var lunaButton: Bool = false
    @State var lunaButtonSize: CGFloat = 120
    @State var lunaButtonIconSize: CGFloat = 15
    @State var lunaButtonBackgroundSize: CGFloat = 150
    @State var lunaButtonCornerSize: CGFloat = 30
    
    @State var zeppelinButtonPressed: Bool = false
    @State var zeppelinButton: Bool = false
    @State var zeppelinButtonSize: CGFloat = 120
    @State var zeppelinButtonIconSize: CGFloat = 15
    @State var zeppelinButtonBackgroundSize: CGFloat = 150
    @State var zeppelinButtonCornerSize: CGFloat = 30
    
    @State var maddieButtonPressed: Bool = false
    @State var maddieButton: Bool = false
    @State var maddieButtonSize: CGFloat = 120
    @State var maddieButtonIconSize: CGFloat = 15
    @State var maddieButtonBackgroundSize: CGFloat = 150
    @State var maddieButtonCornerSize: CGFloat = 30

    
    var body: some View {
            NavigationView {
                ScrollView(showsIndicators: false) {
                            VStack {
                                    VStack {
                                            ZStack {
                            // leshpngo background for the logo
                            Text(vm.onesAndZeros[vm.onesAndZerosIndex])
                                .frame(width: 310, height: 80)
                                .cornerRadius(100)
                                //.font(.system(size:14.3))
                                .font(.system(size:13.35))
                                .lineLimit(nil)
                                .shadow(color: Color.green, radius: 10,  y: 10)
                                .foregroundColor(cvm.homeBrew)
                            // the progression of the 1's and 0's that iterate the index to make an animation
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                                        if vm.onesAndZerosIndex == vm.onesAndZeros.count - 1 {
                                            vm.onesAndZerosIndex = 0
                                        } else {
                                            vm.onesAndZerosIndex += 1
                                        }
                                    }
                                }
                                .zIndex(5)
                                                
                            // name of the app
                        Text("Léshpngo")
                            .font(.system(size: 50))
                            .font(.caption)
                            .foregroundColor(cvm.offBlue)
                            .zIndex(5)
              
                        }
                    }
                    .padding(10)
                    .scaleEffect(1)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(cvm.offBlack)
                            .frame(width: 350, height: expand || expandTwo || expandThree ? 535 : 450)
                            .modifier(Shapes.NeumorphicPopedOutBox())
                            
                        VStack(spacing: 20) {
                            HStack(content:  {
                            })
                            // the label to pick a meditation
                            Text("Chose a meditation").padding()
                                .underline(false)
                                .buttonStyle(.borderless)
                                .foregroundColor(cvm.homeBrew)
                                .frame(width: 220, height: 50)
                                .cornerRadius(40)
                                .modifier(Shapes.NeumorphicClickedBox())
                                .overlay(
                                Text("Choose a meditation")
                                    .foregroundColor(cvm.homeBrew)
                                )
                            
                            ZStack {
                                // background for the vipassana button
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke()
                                    .frame(width: expand ? 300 : 305, height: expand ? 180 : 95)  .foregroundColor(vipassanaButtonPressed ? Color.gray : cvm.homeBrew)
                                    .zIndex(5)
                                if vipassanaButtonPressed == false {
                                    // vipassana meditation link with a description of what meta is
                                    Button(action: {
                                        timerButtonPressed = false
                                        vipassanaButtonPressed = true
                                        metaButtonPressed = false
                                        chosenMeditation = "Vipas"
                                        chiefButtonPressed = true
                                    }, label: {
                                        Text(promptToggle ? "Vipassanā is a way of self-transformation through self-observation by paying attention to the physical sensations that form the life of the body and the mind." : "Vipassanā")
                                            .foregroundColor(cvm.homeBrew)
                                            .font(.system(size: promptToggle ? 14 : 30))
                                            .underline(false)
                                            .lineLimit(6)
                                            .padding(40)
                                        
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: expand ? 290 : 275, height: expand ? 150 : 65)
                                    .modifier(Shapes.NeumorphicRectangle())
                                    .disabled(expand)
                                    // the description of the meditation, so the AI will know what type of meditation to do.
                                    .overlay(
                                        ZStack {
                                            // Vipassana extra info icon that shows what type of meditation it is
                                            Button(action: {
                                                
                                            }, label: {
                                                Image(systemName: expand ? "minus.circle" : "i.circle").resizable().frame(width: 20, height: 20)
                                                    .foregroundColor(cvm.homeBrew)
                                                
                                                    .onTapGesture {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                            expand.toggle()
                                                            
                                                            if expand || expandThree {
                                                                expandTwo = false
                                                                expandThree = false
                                                                promptToggleTwo = false
                                                            }
                                                        }
                                                        promptToggle.toggle()
                                                    }
                                            })
                                            .contentShape(Circle()
                                                .inset(by: -50))
                                            .buttonStyle(.borderless)
                                            .padding( .leading, expand ? 250 : 210)
                                        }
                                    )
                                    .zIndex(4)
                                } else {
                                    ZStack {
                                        Button(action: {
                                        }, label: {
                                   
                                        })
                                        .buttonStyle(.borderless)
                                        .frame(width: 270, height: 75)
                                        .modifier(Shapes.NeumorphicClickedBox())
                                
                                        .overlay(
                                            ZStack {
                                                    HStack {
                                                        Text("Vipassanā")
                                                            .font(.system(size: 25))
                                                            .underline(false)
                                                            .foregroundColor(Color.gray)
                                                     
                                                        Spacer()
                                                            .frame(width: 40)
                                                        
                                                        Image(systemName: "i.circle").resizable().frame(width: 17, height: 17)
                                                            .foregroundColor(Color.gray)
                                                    }
                                        
                                                .buttonStyle(.borderless)
                                            }
                                                .padding(.leading, 50)
                                        )
                                    }
                                }
                            }
                            ZStack {
                                // background for the meta button
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke()
                                    .frame(width: expandTwo ? 300 : 305, height: expandTwo ? 180 : 95)
                                    .foregroundColor(metaButtonPressed ? Color.gray : cvm.homeBrew)
                                    .zIndex(5)
                                // meta meditation link with a description of what meta is
                                if metaButtonPressed == false {
                                    Button(action: {
                                        chiefButtonPressed = false
                                        zeppelinButtonPressed = false
                                        lunaButtonPressed = false
                                        maddieButtonPressed = false
                                        metaButtonPressed = true
                                        vipassanaButtonPressed = false
                                        timerButtonPressed = false

                                        chosenMeditation = "Maitrī"
                                        vm.prompt = """
                                                You are a fully enlighten meta meditation trainer training people through an app. Provide me a non metaphysical meta meditation for an experienced meditator make. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                    }, label: {
                                        Text(promptToggleTwo ? "Meta meditation is a meditation that cultivates compassion for oneself and others by reciting positive phrases and wishes." : "Maitrī")
                                            .foregroundColor(metaButtonPressed ? Color.gray : cvm.homeBrew)
                                            .font(.system(size: promptToggleTwo ? 14 : 30))
                                            .underline(false)
                                            .lineLimit(6)
                                            .padding(40)
                                        
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: expandTwo ? 290 : 275, height: expandTwo ? 150 : 65)
                                    .modifier(Shapes.NeumorphicRectangle())
                                    .cornerRadius(30)
                                    .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                                    .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
                                    .disabled(expandTwo)
                                    .overlay(
                                        ZStack {
                                            // meta extra info icon that shows what type of meditation it is
                                            Button(action: {
                                            }, label: {
                                                Image(systemName: expandTwo ? "minus.circle" : "i.circle").resizable().frame(width: 20, height: 20)
                                                    .foregroundColor(cvm.homeBrew)
                                                    .onTapGesture {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                            expandTwo.toggle()
                                                            
                                                            if expand || expandThree {
                                                                expand = false
                                                                expandThree = false
                                                                promptToggle = false
                                                            }
                                                        }
                                                        promptToggleTwo.toggle()
                                                    }
                                            })
                                            .buttonStyle(.borderless)
                                            .contentShape(Circle()
                                                .inset(by: -50))
                                            .buttonStyle(.borderless)
                                            .padding( .leading, expandTwo ? 250 : 210)
                                        }
                                    )
                                    .zIndex(4)
                                } else {
                                    Button(action: {
                                        metaButtonPressed.toggle()
                                    }, label: {
                           
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: 270, height: 75)
                                    .modifier(Shapes.NeumorphicClickedBox())
                                    .overlay(
                                        ZStack {
                                            HStack {
                                                Text("Maitrī")
                                                    .font(.system(size: 25))
                                                    .underline(false)
                                                    .foregroundColor(Color.gray)
                                                Spacer()
                                                    .frame(width: 60)
                                                
                                                
                                                    Image(systemName: "i.circle").resizable().frame(width: 17, height: 17)
                                                        .foregroundColor(Color.gray)
                                                        .buttonStyle(.borderless)
                                                
                                                
                                            }
                                        }
                                            .padding(.leading, 80)
                                    )
                                    
                                }
            
                            }
                            ZStack {
                                // background for the vipassana button
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke()
                                    .frame(width: expandThree ? 300 : 305, height: expandThree ? 180 : 95)  .foregroundColor(                                        timerButtonPressed ? Color.gray : cvm.homeBrew)
                                    .zIndex(5)
                                if timerButtonPressed == false {
                                    // vipassana meditation link with a description of what meta is
                                    Button(action: {
                                        vipassanaButtonPressed = false
                                        timerButtonPressed = true
                                        metaButtonPressed = false
                                        chosenMeditation = "Vipas"
                                        chiefButtonPressed = true
                                    }, label: {
                                        Text(expandThree ? "" : "Self Timer")
                                            .foregroundColor(cvm.homeBrew)
                                            .font(.system(size: promptToggle ? 14 : 30))
                                            .underline(false)
                                            .lineLimit(6)
                                            .padding(40)
                                        
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: expandThree ? 290 : 275, height: expandThree ? 150 : 65)
                                    .modifier(Shapes.NeumorphicRectangle())
                                    .disabled(expand)
                                    // the description of the meditation, so the AI will know what type of meditation to do.
                                    .overlay(
                                        ZStack {
                                           
                                            VStack {
                                                Spacer()
                                                    .frame(height: 50)
                                                if expandThree {
                                                    VStack(spacing: 5) {
                                                        Text("minutes")
                                                            .foregroundColor(cvm.homeBrew)
                                                            .font(.system(size: 25))
                                                        Text(
                                                            String(format:"%.0f", vm.minuteSliderProgress)
                                                            )
                                                        .foregroundColor(cvm.homeBrew)
                                                        .font(.system(size: 25))
                                                        
                                                        ZStack {
                                                            // green background
                                                            RoundedRectangle(cornerRadius: 100)
                                                                .stroke(lineWidth: 1.5)
                                                                .frame(width: 254, height: 52)
                                                                .foregroundColor(cvm.homeBrew)
                                                            // Slider body
                                                            RoundedRectangle(cornerRadius: 100)
                                                                .foregroundColor(cvm.offBlack)
                                                                .modifier(Shapes.NeumorphicBox())
                                                                .frame(width: 250, height: 50)
                                                            
                                                            ZStack(alignment: .leading, content: {
                                                                // slider itself make the slider have neumorphism
                                                                HStack {
                                                                    Spacer()
                                                                        .frame(width: 35)
                                                                    Circle()
                                                                        .foregroundColor(Color.clear)
                                                                        .frame(width: vm.minuteSliderHeight, height: 13)
                                                                        .modifier(Shapes.NeumorphicSider())
                                                                        .zIndex(6)
                                                                }
                                                                RoundedRectangle(cornerRadius: 100)
                                                                    .foregroundColor(Color.clear)
                                                                    .frame(width: 250, height: 50)
                                                                
                                                                
                                                            })
                                                            .frame(width: vm.minuteMaxHeight)
                                                            // the logic for the slider
                                                            .gesture(DragGesture(minimumDistance:
                                                                                    0).onChanged({ (value) in
                                                                
                                                                let minuteTranslation = value.translation
                                                                
                                                                vm.minuteSliderHeight = minuteTranslation.width + vm.minuteLastDragValue
                                                                
                                                                vm.minuteSliderHeight = vm.minuteSliderHeight > vm.minuteMaxHeight ? vm.minuteMaxHeight : vm.minuteSliderHeight
                                                                
                                                                vm.minuteSliderHeight = vm.minuteSliderHeight >= 0 ?
                                                                vm.minuteSliderHeight : 0
                                                                
                                                                vm.minuteSliderProgress += 1
                                                                
                                                            }) .onEnded({ (value) in
                                                                
                                                                vm.minuteSliderHeight = vm.minuteSliderHeight > vm.minuteMaxHeight ? vm.minuteMaxHeight : vm.minuteSliderHeight
                                                                
                                                                vm.minuteSliderHeight = vm.minuteSliderHeight >= 0 ?
                                                                vm.lessonSliderHeight : 0
                                                                
                                                                vm.minuteLastDragValue = vm.minuteSliderHeight
                                                                vm.minuteSliderHeight = vm.minuteSliderHeight
                                                            }))
                                                        }
                                                        .scaleEffect(0.9)
                                                    }
                                                }
                                                Spacer()
                                                    .frame(height: 50)
                                            }
                                            HStack {
                                            // Vipassana extra info icon that shows what type of meditation it is
                                            Button(action: {
                                                
                                            }, label: {
                                                Image(systemName: expandThree ? "minus.circle" : "clock").resizable().frame(width: 20, height: 20)
                                                    .foregroundColor(cvm.homeBrew)
                                                
                                                    .onTapGesture {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                            expandThree.toggle()
                                                            if expand || expandTwo  {
                                                                expand = false
                                                                expandTwo = false
                                                                promptToggleTwo = false
                                                            }
                                                        }
                                                        
                                                    }
                                                
                                                
                                            })
                                            
                                            .buttonStyle(.borderless)
                                            .padding( .bottom, expandThree ? 100 : 0)
                                            .padding( .leading, expandThree ? 200 : 210)
                                        }
                                        }
                                    )
                                    .zIndex(4)
                                } else {
                                    ZStack {
                                        Button(action: {
                                        }, label: {
                                            
                                        })
                                        .buttonStyle(.borderless)
                                        .frame(width: 270, height: 75)
                                        .modifier(Shapes.NeumorphicClickedBox())
                                        
                                        .overlay(
                                            ZStack {
                                                HStack {
                                                    Text("Self Timer")
                                                        .font(.system(size: 25))
                                                        .underline(false)
                                                        .foregroundColor(Color.gray)
                                                    
                                                    Spacer()
                                                        .frame(width: 40)
                                                    
                                                    Image(systemName: "i.circle").resizable().frame(width: 17, height: 17)
                                                        .foregroundColor(Color.gray)
                                                }
                                                
                                                .buttonStyle(.borderless)
                                            }
                                                .padding(.leading, 50)
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        
                    }
                    .scaleEffect(0.9)
                    
                    ZStack {
                        VStack {
                            Spacer(minLength: 20)
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 350, height: meditationTimeBoxAnimation || menuAnimationSizeChange ? 400 : 170)
                                .foregroundColor(cvm.offBlack)
                                .modifier(Shapes.NeumorphicPopedOutBox())
                                .overlay(
                                    HStack {
                                        Button(action: {
                                            
                                        }, label: {
                                    
                                                HStack(spacing: meditationTimeBoxExpand || menuPopUp ? 40 : 150) {
                                                    Image(systemName:"plus").resizable()       .frame(width: meditationTimeBoxExpand || menuPopUp ? 0 : 30, height: meditationTimeBoxExpand || menuPopUp ? 0 : 20)
                                                        .foregroundColor(cvm.homeBrew)
                                                        .padding(.top, meditationTimeBoxExpand || menuPopUp ? 310 : 100)
                                                        .onTapGesture {
                                                            meditationTimeBoxExpand.toggle()
                                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                                meditationTimeBoxAnimation.toggle()
                                                            }
                                                        }
                                                        .padding(meditationTimeBoxExpand || menuPopUp ? 50 : 0)
                                                    
                                                   
                                                    if meditationTimeBoxExpand || menuPopUp {
                                                        Image(systemName: "chevron.up").resizable()
                                                            .frame(width: 100, height: 20)
                                                        
                                                            .foregroundColor(cvm.homeBrew)
                                                            .padding(.top, meditationTimeBoxExpand || menuPopUp ? 340 : 100)
                                                            .onTapGesture {
                                                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                                    menuPopUp = false
                                                                    meditationTimeBoxExpand = false
                                                                    menuAnimationSizeChange = false
                                                                    meditationTimeBoxAnimation = false
                                                                    profileButtonPressed = false
                                                                }
                                                            }
                                                            .padding(meditationTimeBoxExpand || menuPopUp ? 50 : 0)
                                                    }
                                                    
                                                    Image(systemName: "line.3.horizontal").resizable()
                                                        .frame(width: meditationTimeBoxExpand || menuPopUp ? 0 : 30, height: meditationTimeBoxExpand || menuPopUp ? 0 : 20)
                                                    
                                                        .foregroundColor(cvm.homeBrew)
                                                        .padding(.top, meditationTimeBoxExpand || menuPopUp ? 310 : 100)
                                                        .onTapGesture {
                                                            menuPopUp.toggle()
                                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                                menuAnimationSizeChange.toggle()
                                                            }
                                                        }
                                                        .padding(meditationTimeBoxExpand || menuPopUp ? 50 : 0)
                                                    
                                                }
                                            
                                        })
                                        .buttonStyle(.borderless)
                                    }
                            )
                                .overlay(
                                   
                                        HStack(spacing: 50) {
                                            if profileButtonPressed == false {
                                            Button(action: {
                                                
                                            }, label: {
                                                Text("Logout")
                                                    .foregroundColor(cvm.homeBrew)
                                            })
                                            .frame(width: 120, height: 120)
                                            .modifier(Shapes.NeumorphicPopedOutBox())
                                            .padding(.top, 100)
                                            .scaleEffect(menuPopUp ? 1 : 0)
                                            
                                            Button(action: {
                                                profileButtonPressed = true
                                            }, label: {
                                                Text("Profile")
                                                    .foregroundColor(cvm.homeBrew)
                                                
                                            })
                                            .frame(width: 120, height: 120)
                                            .modifier(Shapes.NeumorphicPopedOutBox())
                                            .padding(.top, 100)
                                            .scaleEffect(menuPopUp ? 1 : 0)
                                            
                                            } else {
                                                HStack {
                                                    
                                                    VStack {
                                                        
                                                        Spacer()
                                                            .frame(height: 120)
                                                        
                                                        Text("Username")
                                                            .frame(width: 100)
                                                            .foregroundColor(cvm.homeBrew)
                                                        
                                                        Button(action: {}, label: {
                                                            Text(vm.loginUsernameText)
                                                        })
                                                        .frame(width: 200, height: 40)
                                                        .modifier(Shapes.NeumorphicClickedBox())
                                                        
                                                        Text("Password")
                                                            .frame(width: 100)
                                                            .foregroundColor(cvm.homeBrew)
                                                        
                                                        Button(action: {}, label: {
                                                            Text(vm.loginUsernameText)
                                                            
                                                        })
                                                        .frame(width: 200, height: 40)
                                                        .modifier(Shapes.NeumorphicClickedBox())
                                                    }
                                               
                                                    
                                                }
                                            }
                                        }
                                    
                                )
             
                                .overlay(
                                  
                                    VStack {
                                        HStack(spacing: 60) {
                                            VStack {
                                                
                                                Text("DAYS:")
                                                    .scaleEffect(meditationTimeBoxAnimation ? 1 : 0)
                                                    .foregroundColor(cvm.homeBrew)
                                                    .padding(.top, 150)
                                                Rectangle()
                                                    .foregroundColor(cvm.offBlack)
                                                    .modifier(Shapes.NeumorphicClickedBox())
                                                    .frame(width: meditationTimeBoxAnimation ? 100 : 0, height: meditationTimeBoxAnimation ? 75 : 0)
                                                    .overlay(
                                                        Text("999")
                                                            .scaleEffect(meditationTimeBoxAnimation ? 1 : 0)
                                                            .foregroundColor(cvm.homeBrew)
                                                    )
                                            }
                                                    VStack {
                                                        Text("HOURS:")
                                                            .scaleEffect(meditationTimeBoxAnimation ? 1 : 0)
                                                            .foregroundColor(cvm.homeBrew)
                                                            .padding(.top, 150)
                                                        Rectangle()
                                                            .foregroundColor(cvm.offBlack)
                                                            .frame(width: meditationTimeBoxAnimation ? 100 : 0, height: meditationTimeBoxAnimation ? 75 : 0)
                                                            .modifier(Shapes.NeumorphicClickedBox())
                                                            .overlay(
                                                                Text("999")
                                                                    .scaleEffect(meditationTimeBoxAnimation ? 1 : 0)
                                                                    .foregroundColor(cvm.homeBrew)
                                                            )
                                        }
                                    }
                                })
                            }
                        
                        VStack {
                            HStack(spacing: 0) {
                                Spacer()
                                    .frame(width: 300)
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                            .frame(width: 150)
                                        VStack {
                                            RoundedRectangle(cornerRadius: 30)
                                                .modifier(Shapes.NeumorphicClickedBox())
                                                .font(.system(size: 15))
                                                .padding(.leading, 0)
                                                .padding(.trailing, 0)
                                                .frame(height: 60)
                                                .overlay(
                                                Text(chosenMeditation)
                                                    .foregroundColor(cvm.homeBrew)
                                     
                                                )
                                            Spacer()
                                                .frame(height: 15)
                                        }
                                    }
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .frame(width: 120, height: 0.66)
                                            .foregroundColor(cvm.homeBrew)
                                            .padding(.bottom, 80)
                                        Rectangle()
                                            .frame(width: 120, height: 1)
                                            .foregroundColor(cvm.homeBrew)
                                            .padding(.bottom, 80)
                                    }
                                }
                                VStack {
                                    Spacer()
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .stroke()
                                                .frame(width: 110, height: 110)
                                                .foregroundColor(cvm.homeBrew)
                                                .padding(.bottom, 30)
                                                .zIndex(3)

                                                // lession play button
                                                NavigationLink(destination: MeditationGenerator(vm: vm), label: {
                                                    Image(systemName: "figure.mind.and.body").resizable().frame(width: 40, height: 40)
                                                        .underline(false)
                                                        .foregroundColor(cvm.homeBrew)
                                         
                                                })
                                                .onAppear {
                                                        startMeditation = false
                                                    }
                                                .buttonStyle(.borderless)
                                                .frame(width: 80, height: 80)
                                                .modifier(Shapes.NeumorphicCircle())
                                                .padding(.bottom, 30)
                                        }
                                    }
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        VStack {
                                            RoundedRectangle(cornerRadius: 30)
                                                .modifier(Shapes.NeumorphicClickedBox())
                                                .font(.system(size: 15))
                                                .padding(.leading, 0)
                                                .padding(.trailing, 0)
                                                .frame(height: 60)
                                                .overlay(
                                                    Text(chosenInstructor)
                                                        .foregroundColor(cvm.homeBrew)
                                                 
                                                )
                                            Spacer()
                                                .frame(height: 15)
                                        }
                                        Spacer()
                                            .frame(width: 150)
                                    }
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .frame(width: 120, height: 1)
                                            .foregroundColor(cvm.homeBrew)
                                            .padding(.bottom, 80)
                                        Rectangle()
                                            .frame(width: 120, height: 0.66)
                                            .foregroundColor(cvm.homeBrew)
                                            .padding(.bottom, 80)
                                            

                                    }
                                }
                                Spacer()
                                    .frame(width: 300)
                            }
                            Spacer()
                                .frame(height: meditationTimeBoxAnimation || menuAnimationSizeChange ? 200 : 0)
                        }
                    }
                    .scaleEffect(0.9)
                }
                Spacer()
                    .frame(height: 20)
               
                    
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width:350, height: 420)
                        .foregroundColor(cvm.offBlack)
                        .modifier(Shapes.NeumorphicPopedOutBox())
                        .padding(.top, 0)
                    
                    VStack(spacing: 15) {
                        ZStack {
                            HStack(content:  {
                                
                                // the label for choosing different instructors
                                RoundedRectangle(cornerRadius: 30)
                                    .buttonStyle(.borderless)
                         
                                    
                            })
                            .frame(width: 200, height: 50)
                            .cornerRadius(40)
                            .modifier(Shapes.NeumorphicClickedBox())
                            .overlay(
                            Text("pick an instructer")
                                .underline(false)
                                .foregroundColor(cvm.homeBrew)
                            )
                            .zIndex(7)
                        }
                        HStack {
                            Grid(horizontalSpacing: gridSpacing) {
                                GridRow {
                                    VStack(spacing: 10) {
                                        ZStack {
                                            //  green background for the Chief instructor
                                            
                                            RoundedRectangle(cornerRadius: chiefButtonCornerSize)
                                                .stroke()
                                                .frame(width:  chiefButtonBackgroundSize, height:  chiefButtonBackgroundSize)
                                                .foregroundColor(chiefButtonPressed ? Color.gray : cvm.homeBrew )
                                                .zIndex(2)
                                            if chiefButtonPressed == false  {
                                                // Chief meditation instructor link with a description of how Chief will guid a meditation.
                                                Button(action: {
                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                        vipassanaButtonPressed = true
                                                        metaButtonPressed = false
                                                        lunaButtonPressed = false
                                                        zeppelinButtonPressed = false
                                                        maddieButtonPressed = false
                                                        chiefButtonPressed.toggle()
                                                    }
                                                    vm.prompt = """
You are a fully enlighten vipassana meditation trainer, training people through an app. give me a non metaphysical meditation for a beginner meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                    chosenInstructor = "Chief"
                                                }, label: {
                                                    Text(chiefButton ? "Say hello to Chief, Chief is a well trained meditation instructor that is great at guiding beginners through an eyes closed meditation. Chief will connect you with the world using concepts found within your self." : "Chief")
                                                        .underline(false)
                                                        .foregroundColor(cvm.homeBrew)
                                                        .font(.system(size: chiefButton ? 16 : 16))
                                                        .frame(width: chiefButton ? 200 : 60, height: chiefButton ? 200 : 20)
                                                })
                                                .disabled(chiefButton)
                                                .buttonStyle(.borderless)
                                                .frame(width:  chiefButtonSize, height: chiefButtonSize)
                                                // nuemorphic design
                                                .modifier(Shapes.NeumorphicPopedOutBox())
                                                .overlay(
                                                    ZStack {
                                                        // Chief extra info icon that shows what type of meditation this instructor does
                                                        Button(action: {
                                                        }, label: {
                                                            Image(systemName: chiefButton ? "minus.circle" : "i.circle").resizable().frame(width: chiefButtonIconSize, height: chiefButtonIconSize)
                                                                .foregroundColor(cvm.homeBrew)
                                                                .onTapGesture {
                                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                        lunaButtonPressed = false
                                                                        zeppelinButtonPressed = false
                                                                        maddieButtonPressed = false
                                                                        chiefButton.toggle()
                                                                        if chiefButton {
                                                                            gridSpacing = 0
                                                                            
                                                                            chiefButtonSize = 250
                                                                            chiefButtonIconSize = 22
                                                                            chiefButtonBackgroundSize = 270
                                                                            
                                                                            zeppelinButtonSize = 0
                                                                            zeppelinButtonIconSize = 0
                                                                            zeppelinButtonBackgroundSize = 0
                                                                            zeppelinButtonCornerSize = 100
                                                                            
                                                                            lunaButtonSize = 0
                                                                            lunaButtonIconSize = 0
                                                                            lunaButtonBackgroundSize = 0
                                                                            lunaButtonCornerSize = 100
                                                                            
                                                                            maddieButtonSize = 0
                                                                            maddieButtonIconSize = 0
                                                                            maddieButtonBackgroundSize = 0
                                                                            maddieButtonCornerSize = 100
                                                                        }  else {
                                                                            gridSpacing = 10
                                                                            
                                                                            zeppelinButtonSize = 120
                                                                            zeppelinButtonIconSize = 15
                                                                            zeppelinButtonBackgroundSize = 150
                                                                            zeppelinButtonCornerSize = 30
                                                                            
                                                                            chiefButtonSize = 120
                                                                            chiefButtonIconSize = 15
                                                                            chiefButtonBackgroundSize = 150
                                                                            chiefButtonCornerSize = 30
                                                                            
                                                                            lunaButtonSize = 120
                                                                            lunaButtonIconSize = 15
                                                                            lunaButtonBackgroundSize = 150
                                                                            lunaButtonCornerSize = 30
                                                                            
                                                                            maddieButtonSize = 120
                                                                            maddieButtonIconSize = 15
                                                                            maddieButtonBackgroundSize = 150
                                                                            maddieButtonCornerSize = 30
                                                                        }
                                                                    }
                                                                }
                                                        })
                                                        .contentShape(Circle()
                                                            .inset(by: -10))
                                                        .buttonStyle(.borderless)
                                                        .padding( .top, chiefButton ? 200 : 70)
                                                    })
                                            } else if chiefButtonPressed  {
                                                ZStack {
                                                    Button(action: {
                                                        
                                                    }, label: {
                                      
                                                    })
                                                    .buttonStyle(.borderless)
                                                    .frame(width: 130, height: 130)
                                                    .modifier(Shapes.NeumorphicClickedBox())
                                                    .overlay(
                                                        ZStack {
                                                            // Maddie extra info icon that shows what type of meditation this instructor does
                                                            
                                                            Text("Chief")
                                                                .font(.system(size: 13))
                                                                .underline(false)
                                                                .foregroundColor(Color.gray)
                                                            
                                                            Button(action: {
                                                            }, label: {
                                                                Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                                    .foregroundColor(Color.gray)
                                                            })
                                                            .buttonStyle(.borderless)
                                                            .padding(.top, 70)
                                                    }
                                                )}
                                            }
                                        }
                                        ZStack {
                                            RoundedRectangle(cornerRadius: lunaButtonCornerSize)
                                                .stroke()
                                                .frame(width: lunaButtonBackgroundSize, height: lunaButtonBackgroundSize)
                                                .foregroundColor(lunaButtonPressed ? Color.gray : cvm.homeBrew ) .zIndex(6)
                                            if lunaButtonPressed == false {
                                                // Luna meditation instructor link with a description of how Luna will guid a meditation.
                                                Button(action: {
                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                        vipassanaButtonPressed = true
                                                        metaButtonPressed = false
                                                        chiefButtonPressed = false
                                                        zeppelinButtonPressed = false
                                                        maddieButtonPressed = false
                                                        lunaButtonPressed.toggle()
                                                    }
                                                    vm.prompt = """
You are a fully enlighten vipassana meditation trainer training people through an app. Please create a non metaphysical meditation for experiencing nature; guide the person with all the moments of nature around them . Provide three dots: "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                    
                                                    chosenInstructor = "Luna"
                                                }, label: {
                                                    Text(lunaButton ? "Nurture yourself with nature. Go outside, Luna will guide you through a meditation that will connect you to the surroundings of nature.": "Luna")
                                                    
                                                        .underline(false)
                                                        .foregroundColor(cvm.homeBrew)
                                                        .font(.system(size: lunaButton ? 20 : 17))
                                                        .frame(width: lunaButton ? 200 : 50, height: lunaButton ? 200 : 20)
                                                    
                                                })
                                                .disabled(lunaButton)
                                                .buttonStyle(.borderless)
                                                .frame(width: lunaButtonSize, height: lunaButtonSize)
                                                .modifier(Shapes.NeumorphicPopedOutBox())
                                                .overlay(
                                                    ZStack {
                                                        
                                                        // Luna extra info icon that shows what type of meditation this instructor does
                                                        Button(action: {
                                                        }, label: {
                                                            Image(systemName: lunaButton ? "minus.circle" : "i.circle").resizable().frame(width: lunaButtonIconSize, height: lunaButtonIconSize)
                                                                .foregroundColor(cvm.homeBrew)
                                                                .onTapGesture {
                                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                        chiefButtonPressed = false
                                                                        zeppelinButtonPressed = false
                                                                        maddieButtonPressed = false
                                                                        
                                                                        lunaButton.toggle()
                                                                        if lunaButton {
                                                                            gridSpacing = 0
                                                                            
                                                                            lunaButtonSize = 250
                                                                            lunaButtonBackgroundSize = 270
                                                                            lunaButtonIconSize = 22
                                                                            
                                                                            chiefButtonSize = 0
                                                                            chiefButtonIconSize = 0
                                                                            chiefButtonBackgroundSize = 0
                                                                            chiefButtonCornerSize = 100
                                                                            
                                                                            maddieButtonSize = 0
                                                                            maddieButtonIconSize = 0
                                                                            maddieButtonBackgroundSize = 0
                                                                            maddieButtonCornerSize = 100
                                                                            
                                                                            zeppelinButtonSize = 0
                                                                            zeppelinButtonIconSize = 0
                                                                            zeppelinButtonBackgroundSize = 0
                                                                            zeppelinButtonCornerSize = 100
                                                                            
                                                                        }  else {
                                                                            gridSpacing = 10
                                                                            
                                                                            lunaButtonSize = 120
                                                                            lunaButtonIconSize = 15
                                                                            lunaButtonBackgroundSize = 150
                                                                            lunaButtonCornerSize = 30
                                                                            
                                                                            zeppelinButtonSize = 120
                                                                            zeppelinButtonIconSize = 15
                                                                            zeppelinButtonBackgroundSize = 150
                                                                            zeppelinButtonCornerSize = 30
                                                                            
                                                                            chiefButtonSize = 120
                                                                            chiefButtonIconSize = 15
                                                                            chiefButtonBackgroundSize = 150
                                                                            chiefButtonCornerSize = 30
                                                                            
                                                                            
                                                                            maddieButtonSize = 120
                                                                            maddieButtonIconSize = 15
                                                                            maddieButtonBackgroundSize = 150
                                                                            maddieButtonCornerSize = 30
                                                                    }
                                                                }
                                                            }
                                                        })
                                                        .contentShape(Circle()
                                                            .inset(by: -10))
                                                        .buttonStyle(.borderless)
                                                        .padding( .top, lunaButton ? 200 : 70)
                                                    })
                                            } else {
                                                ZStack {
                                                    Button(action: {
                                                        
                                                    }, label: {
                                                        
                                                       
                                                    })
                                                    .buttonStyle(.borderless)
                                                    .frame(width: 130, height: 130)
                                                    .modifier(Shapes.NeumorphicClickedBox())
                                                    .overlay(
                                                        ZStack {
                                                            // Maddie extra info icon that shows what type of meditation this instructor does
                                                            Text("Luna")
                                                                .font(.system(size: 13))
                                                                .underline(false)
                                                                .foregroundColor(Color.gray)
                                                            
                                                            Button(action: {
                                                            }, label: {
                                                                Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                                    .foregroundColor(Color.gray)
                                                            })
                                                            .buttonStyle(.borderless)
                                                            .padding(.top, 70)
                                                    }
                                                )}
                                            }
                                        }
                                    }
                                    GridRow {
                                        VStack(spacing: 10){
                                            ZStack {
                                                RoundedRectangle(cornerRadius: zeppelinButtonCornerSize)
                                                    .stroke()
                                                    .frame(width: zeppelinButtonBackgroundSize, height: zeppelinButtonBackgroundSize)
                                                    .foregroundColor(zeppelinButtonPressed ? Color.gray : cvm.homeBrew )
                                                    .zIndex(6)
                                                
                                                if zeppelinButtonPressed == false {
                                                    // Zeppelin meditation instructor link with a description of how Zeppelin will guid a meditation.
                                                    Button(action: {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                            vipassanaButtonPressed = true
                                                            metaButtonPressed = false
                                                            chiefButtonPressed = false
                                                            lunaButtonPressed = false
                                                            maddieButtonPressed = false
                                                            zeppelinButtonPressed.toggle()
                                                        }
                                                        vm.prompt = """
You are a fully enlighten vipassana meditation trainer training people through an app. Please create me a non metaphysical meditation for an experienced meditator guiding the person with an eyes open meditation. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                        chosenInstructor = "Zepp"
                                                    }, label: {
                                                        Text(zeppelinButton ? "Zepp is an excellent teacher that guides a body awareness exercise. Wake yourself up, with Zeppelin meditation." :"Zepp")
                                                            .underline(false)
                                                            .foregroundColor(cvm.homeBrew)
                                                            .font(.system(size: zeppelinButton ? 20 : 15))
                                                            .frame(width: zeppelinButton ? 200 : 60, height: zeppelinButton ? 200 : 20)
                                                    })
                                                    .disabled(zeppelinButton)
                                                    .buttonStyle(.borderless)
                                                    .frame(width: zeppelinButtonSize, height: zeppelinButtonSize)
                                                    .modifier(Shapes.NeumorphicPopedOutBox())
                                                    .overlay(
                                                        ZStack {
                                                            // Zeppelin extra info icon that shows what type of meditation this instructor does
                                                            Button(action: {
                                                            }, label: {
                                                                Image(systemName: zeppelinButton ? "minus.circle" : "i.circle").resizable().frame(width: zeppelinButtonIconSize, height: zeppelinButtonIconSize)
                                                                    .foregroundColor(cvm.homeBrew)
                                                                    .onTapGesture {
                                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                            
                                                                            chiefButtonPressed = false
                                                                            lunaButtonPressed = false
                                                                            maddieButtonPressed = false
                                                                            
                                                                            zeppelinButton.toggle()
                                                                            if zeppelinButton {
                                                                                gridSpacing = 5
                                                                                
                                                                                zeppelinButtonSize = 250
                                                                                zeppelinButtonBackgroundSize = 270
                                                                                zeppelinButtonIconSize = 22
                                                                                
                                                                                chiefButtonSize = 0
                                                                                chiefButtonIconSize = 0
                                                                                chiefButtonBackgroundSize = 0
                                                                                chiefButtonCornerSize = 100
                                                                                
                                                                                lunaButtonSize = 0
                                                                                lunaButtonIconSize = 0
                                                                                lunaButtonBackgroundSize = 0
                                                                                lunaButtonCornerSize = 100
                                                                                
                                                                                maddieButtonSize = 0
                                                                                maddieButtonIconSize = 0
                                                                                maddieButtonBackgroundSize = 0
                                                                                maddieButtonCornerSize = 100
                                                                            }  else {
                                                                                gridSpacing = 10
                                                                                
                                                                                zeppelinButtonSize = 120
                                                                                zeppelinButtonIconSize = 15
                                                                                zeppelinButtonBackgroundSize = 150
                                                                                zeppelinButtonCornerSize = 30
                                                                                
                                                                                chiefButtonSize = 120
                                                                                chiefButtonIconSize = 15
                                                                                chiefButtonBackgroundSize = 150
                                                                                chiefButtonCornerSize = 30
                                                                                
                                                                                lunaButtonSize = 120
                                                                                lunaButtonIconSize = 15
                                                                                lunaButtonBackgroundSize = 150
                                                                                lunaButtonCornerSize = 30
                                                                                
                                                                                maddieButtonSize = 120
                                                                                maddieButtonIconSize = 15
                                                                                maddieButtonBackgroundSize = 150
                                                                                maddieButtonCornerSize = 30
                                                                            }
                                                                        }
                                                                    }
                                                            })
                                                            .contentShape(Circle()
                                                                .inset(by: -10))
                                                            .buttonStyle(.borderless)
                                                            .padding( .top, zeppelinButton ? 200 : 70)
                                                        })
                                                } else {
                                                    ZStack {
                                                        Button(action: {
                                                            
                                                        }, label: {
                                                            
                                                            
                                                        })
                                                        .buttonStyle(.borderless)
                                                        .frame(width: 130, height: 130)
                                                        .modifier(Shapes.NeumorphicClickedBox())
                                                        .overlay(
                                                            ZStack {
                                                                
                                                                // Maddie extra info icon that shows what type of meditation this instructor does
                                                                Text("Zepp")
                                                                    .font(.system(size: 13))
                                                                    .underline(false)
                                                                    .foregroundColor(Color.gray)
                                                                
                                                                Button(action: {
                                                                }, label: {
                                                                    Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                                        .foregroundColor(Color.gray)
                                                                })
                                                                .buttonStyle(.borderless)
                                                                .padding(.top, 70)
                                                        }
                                                    )}
                                                }
                                            }
                                            ZStack {
                                                RoundedRectangle(cornerRadius: maddieButtonCornerSize)
                                                    .stroke()
                                                    .frame(width: maddieButtonBackgroundSize, height: maddieButtonBackgroundSize)
                                                    .foregroundColor(maddieButtonPressed ? Color.gray : cvm.homeBrew )                                                    .zIndex(6)
                                                if maddieButtonPressed == false {
                                                    // Maddie meditation instructor link with a description of how Maddie will guid a meditation.
                                                    Button(action: {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                            vipassanaButtonPressed = true
                                                            metaButtonPressed = false
                                                            chiefButtonPressed = false
                                                            lunaButtonPressed = false
                                                            zeppelinButtonPressed = false
                                                            maddieButtonPressed.toggle()
                                                        }
                                                        vm.prompt = """
                                                    You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an experienced meditator, have the meditator feel the hart beating as the object of meditation for the practice. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                        chosenInstructor = "Matil"
                                                    }, label: {
                                                        Text(maddieButton ? "Feel the life of your hart, realizing the grounding nature of what makes your life...your life" : "Matil")
                                                            .underline(false)
                                                            .foregroundColor(cvm.homeBrew)
                                                            .font(.system(size: maddieButton ? 20 : 15))
                                                            .frame(width: maddieButton ? 200 : 60, height: maddieButton ? 200 : 10)
                                                        
                                                    })
                                                    .disabled(maddieButton)
                                                    .buttonStyle(.borderless)
                                                    .frame(width: maddieButtonSize, height: maddieButtonSize)
                                                    // nuemorphic design
                                                    .modifier(Shapes.NeumorphicPopedOutBox())
                                                    .overlay(
                                                        ZStack {
                                                            // Maddie extra info icon that shows what type of meditation this instructor does
                                                            Button(action: {
                                                            }, label: {
                                                                Image(systemName: maddieButton ? "minus.circle" : "i.circle").resizable().frame(width: maddieButtonIconSize, height: maddieButtonIconSize)
                                                                    .foregroundColor(cvm.homeBrew)
                                                                    .onTapGesture {
                                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                            chiefButtonPressed = false
                                                                            lunaButtonPressed = false
                                                                            zeppelinButtonPressed = false
                                                                            
                                                                            maddieButton.toggle()
                                                                            
                                                                            if maddieButton {
                                                                                gridSpacing = 5
                                                                                
                                                                                maddieButtonSize = 250
                                                                                maddieButtonBackgroundSize = 270
                                                                                maddieButtonIconSize = 22
                                                                                
                                                                                chiefButtonSize = 0
                                                                                chiefButtonIconSize = 0
                                                                                chiefButtonBackgroundSize = 0
                                                                                chiefButtonCornerSize = 100
                                                                                
                                                                                lunaButtonSize = 0
                                                                                lunaButtonIconSize = 0
                                                                                lunaButtonBackgroundSize = 0
                                                                                lunaButtonCornerSize = 100
                                                                                lunaButtonIconSize = 0
                                                                                
                                                                                zeppelinButtonSize = 0
                                                                                zeppelinButtonBackgroundSize = 0
                                                                                zeppelinButtonCornerSize = 100
                                                                            }  else {
                                                                                gridSpacing = 10
                                                                                
                                                                                maddieButtonSize = 120
                                                                                maddieButtonIconSize = 15
                                                                                maddieButtonBackgroundSize = 140
                                                                                maddieButtonCornerSize = 30
                                                                                
                                                                                zeppelinButtonSize = 120
                                                                                zeppelinButtonIconSize = 15
                                                                                zeppelinButtonBackgroundSize = 140
                                                                                zeppelinButtonCornerSize = 30
                                                                                
                                                                                chiefButtonSize = 120
                                                                                chiefButtonIconSize = 15
                                                                                chiefButtonBackgroundSize = 140
                                                                                chiefButtonCornerSize = 30
                                                                                
                                                                                lunaButtonSize = 120
                                                                                lunaButtonIconSize = 15
                                                                                lunaButtonBackgroundSize = 140
                                                                                lunaButtonCornerSize = 30
                                                                        }
                                                                    }
                                                                }
                                                            })
                                                            .contentShape(Circle()
                                                                .inset(by: -10))
                                                            .buttonStyle(.borderless)
                                                            .padding( .top, maddieButton ? 200 : 70)
                                                        })
                                                } else {
                                                    ZStack {
                                                        Button(action: {
                                                            
                                                        }, label: {
                                                            
                                                    
                                                        })
                                                        .buttonStyle(.borderless)
                                                        .frame(width: 130, height: 130)
                                                        .modifier(Shapes.NeumorphicClickedBox())
                                          
                                                        .overlay(
                                                            ZStack {
                                                                // Maddie extra info icon that shows what type of meditation this instructor does
                                                                Text("Matil")
                                                                    .font(.system(size: 13))
                                                                    .underline(false)
                                                                    .foregroundColor(Color.gray)
                                                                
                                                                Button(action: {
                                                                }, label: {
                                                                    Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                                        .foregroundColor(Color.gray)
                                                                })
                                                                .buttonStyle(.borderless)
                                                                .padding(.top, 70)
                                                        }
                                                    )}
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .scaleEffect(0.9)
                        Spacer()
                            .frame(height: 15)
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 350, height: 450)
                        .foregroundColor(cvm.offBlack)
                        .modifier(Shapes.NeumorphicPopedOutBox())
                    if viewModel.GPTLoading {
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: cvm.homeBrew))
                                .scaleEffect(2)
                                .zIndex(6)
                            
                            Spacer()
                                .frame(height: 170)
                        }
                    }
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        ZStack {
                            HStack(content:  {
                                
                                
                       RoundedRectangle(cornerRadius: 30)
                
                                
                            })
                            .frame(width: 130, height: 50)
                            .cornerRadius(40)
                            .modifier(Shapes.NeumorphicClickedBox())
                            .overlay(
                                // the label for describing the lesions section
                                Text("lessions").padding()
                                    .underline(false)
                                    .buttonStyle(.borderless)
                                    .foregroundColor(cvm.homeBrew)
                                
                            )
                            .zIndex(7)
                            
                        }

                        Spacer(minLength: 200)

                    }
                    ZStack {
                        // green background for the text box
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .frame(width: 355, height: 400)
                            .foregroundColor(cvm.homeBrew)
                            .scaleEffect(0.9)

                            .zIndex(2)
                        ZStack {
                            VStack {
                                ScrollView {
                                    if vm.startLessonPrompt {
                                                    Image(systemName: "arrow.2.squarepath")
                                                           .position(x: 67, y: 67)
                                            // .position(x: 167, y: 77)
                                            HStack {
                                                
                                                Text("Generate a lesson by pressing the         button.")
                                                    .frame(width: 280, height: 60)
                                                Spacer(minLength: 20)
                                            }
                                        }
                                    // The text that is generated for the lesions
                                    ForEach(viewModel.messages.filter({$0.role != .system}),
                                         id: \.id) { meditationMessage in
                                        messageView(message: meditationMessage)
                                    }
                                        .position(x:140, y: 270)
                                        .frame(width: 280, height: 500)
                                }
                            }
                            .onAppear {
                                vm.setup()
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
                            // the box that holds the text for the lesion
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.clear)
                                .frame(width: 350, height: 400)
                                .modifier(Shapes.NeumorphicBox())
                                .zIndex(3)
                        }
                        .scaleEffect(0.9)

                    }

                }
                .scaleEffect(0.9)

                    // status bar for audio
                    ZStack {
                     
                
                        // green background
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(lineWidth: 1.5)
                            .frame(width: 334, height: 62)
                            .foregroundColor(cvm.homeBrew)
                        // Slider body
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
                                    .frame(width: vm.lessonSliderHeight, height: 13)
                                    .modifier(Shapes.NeumorphicSider())
                                    .zIndex(6)
                            }
                            RoundedRectangle(cornerRadius: 100)
                                .foregroundColor(Color.clear)
                                .frame(width: 330, height: 60)
                    
            
                        })
                        .frame(width: vm.lessonMaxHeight)
                        // the logic for the slider
                        .gesture(DragGesture(minimumDistance:
                                                0).onChanged({ (value) in
                            
                            let lessonTranslation = value.translation
                            
                            vm.lessonSliderHeight = lessonTranslation.width + vm.lessonLastDragValue
                            
                            vm.lessonSliderHeight = vm.lessonSliderHeight > vm.lessonMaxHeight ? vm.lessonMaxHeight : vm.lessonSliderHeight
                            
                            vm.lessonSliderHeight = vm.lessonSliderHeight >= 0 ?
                            vm.lessonSliderHeight : 0
                            
                            vm.lessonSliderProgress += 5
                            
                        }) .onEnded({ (value) in
                            
                            vm.lessonSliderHeight = vm.lessonSliderHeight > vm.lessonMaxHeight ? vm.lessonMaxHeight : vm.lessonSliderHeight
                            
                            vm.lessonSliderHeight = vm.lessonSliderHeight >= 0 ?
                            vm.lessonSliderHeight : 0
                            
                            vm.lessonLastDragValue = vm.lessonSliderHeight
                            vm.lessonSliderHeight = vm.lessonSliderHeight
                        }))
                    }
                    .scaleEffect(0.9)
                    .padding(10)

                    VStack {
                        Spacer(minLength: 30)
                        HStack(spacing: 40) {
                            
                            if playing {
                                
                                // lession play button
                                Button(action: {
                                    playing.toggle()
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
                                    playing.toggle()
                                }, label: {
                                    Image(systemName:  "pause.circle").resizable().frame(width: 55, height: 55) // play button
                                        .foregroundColor(cvm.pauseRed)
                                })
                                .buttonStyle(.borderless)
                                .frame(width: 150, height: 150)
                                // nuemorphic design
                                .modifier(Shapes.NeumorphicCirclePushedIn())
                                .zIndex(4)
                            }
                            if pressedReset {
                                // generate meditation button
                                Button(action: {
                                    // viewModel.sendMediationMessage()
                                viewModel.currentInput = "Teach me about vipassana meditation without waking me through a meditation."
                                    viewModel.sendMessage()
                                    vm.startLessonPrompt = false
                                    vm.startMeditationPrompt = false
                                    pressedReset = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        pressedReset = true
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
                                Button(action: {},
                                       label: {
                                    
                                    Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                                        .foregroundColor(cvm.homeBrew)
                                    
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
                        
                    }
                    .scaleEffect(0.9)

                }
                .frame(minWidth: 900, maxWidth: 1000, minHeight: 700, maxHeight: 2500)
                .background(LinearGradient (
                    
                    gradient: Gradient(colors: [cvm.offBlue, cvm.backgroundAppColor]),
                    startPoint: .bottom,
                    endPoint: .top))

            }
        }
    func messageView(message: Message) -> some View {
        HStack {
            Text(message.content)
            if message.role == .assistant {Spacer()}
        }
    }
}

struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
