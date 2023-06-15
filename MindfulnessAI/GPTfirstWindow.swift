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

struct FirstView: View {
    
    @ObservedObject var vm = ViewModel()
    
    @ObservedObject var cvm = ColorViewModel()
    
    @ObservedObject var shapeVm = Shapes()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack {
                    
                    VStack {
                        
                        ZStack {
                            Spacer()
                            // leshpngo background for the logo
                            Text(vm.onesAndZeros[vm.onesAndZerosIndex])
                                .frame(width: 360, height: 120)
                                .cornerRadius(60)
                                .font(.system(size:14.3))
                            //  .font(.system(size:13.35))
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
                                .font(.system(size: 70))
                                .font(.caption)
                                .foregroundColor(cvm.offBlue)
                                .zIndex(5)
                            
                        }
                    }
                    .padding(20)
                    .scaleEffect(1)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(cvm.offBlack)
                            .frame(width: 350, height: 350)
                            .modifier(Shapes.NeumorphicPopedOutBox())
                        
                        VStack(spacing: 10) {
                            
                            HStack(content:  {
                                
                            })
                            // the label to pick a meditation
                            Text("Chose a meditation").padding()
                                .underline(false)
                                .buttonStyle(.borderless)
                                .foregroundColor(cvm.homeBrew)
                                .frame(width: 260, height: 70)
                                .cornerRadius(40)
                                .modifier(Shapes.NeumorphicBox())
                            
                            ZStack {
                                
                                // background for the vipassana button
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke()
                                    .frame(width: vm.expand ? 300 : 290, height: vm.expand ? 180 : 95)  .foregroundColor(vm.vipassanaButtonPressed ? Color.gray : cvm.homeBrew)
                                    .zIndex(5)
                                if vm.vipassanaButtonPressed == false {
                                    // vipassana meditation link with a description of what meta is
                                    Button(action: {
                                        vm.vipassanaButtonPressed = true
                                        vm.metaButtonPressed = false
                                        vm.chosenMeditation = "Vipas"
                                    }, label: {
                                        Text(vm.promptToggle ? "Vipassanā is a way of self-transformation through self-observation by paying attention to the physical sensations that form the life of the body and the mind." : "Vipassanā")
                                            .foregroundColor(cvm.homeBrew)
                                            .font(.system(size: vm.promptToggle ? 14 : 30))
                                            .underline(false)
                                            .lineLimit(6)
                                            .padding(40)
                                        
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: vm.expand ? 290 : 275, height: vm.expand ? 150 : 65)
                                    .modifier(Shapes.NeumorphicRectangle())
                                    
                                    // the description of the meditation, so the AI will know what type of meditation to do.
                                    .overlay(
                                        ZStack {
                                            
                                            // Vipassana extra info icon that shows what type of meditation it is
                                            Button(action: {
                                                
                                            }, label: {
                                                Image(systemName: vm.expand ? "minus.circle" : "i.circle").resizable().frame(width: 20, height: 20)
                                                    .foregroundColor(cvm.homeBrew)
                                                
                                                    .onTapGesture {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                            vm.expand.toggle()
                                                            
                                                            if vm.expand && vm.expandTwo == true {
                                                                vm.expandTwo = false
                                                                vm.promptToggleTwo = false
                                                            }
                                                        }
                                                        vm.promptToggle.toggle()
                                                    }
                                            })
                                            .contentShape(Circle()
                                                .inset(by: -50))
                                            .buttonStyle(.borderless)
                                            .padding( .leading, vm.expand ? 250 : 210)
                                        }
                                    )
                                    .zIndex(4)
                                } else {
                                    ZStack {
                                        Button(action: {
                                            vm.vipassanaButtonPressed.toggle()
                                        }, label: {
                                            Text("Vipassanā")
                                                .font(.system(size: 25))
                                                .underline(false)
                                                .foregroundColor(Color.gray)
                                        })
                                        .buttonStyle(.borderless)
                                        .frame(width: 300, height: 95)
                                        .modifier(Shapes.NeumorphicBox())
                                        .overlay(
                                            ZStack {
                                                Button(action: {}, label: {
                                                    Image(systemName: "i.circle").resizable().frame(width: 17, height: 17)
                                                        .foregroundColor(Color.gray)
                                                })
                                                .buttonStyle(.borderless)
                                                
                                            }
                                                .padding(.leading, 210)
                                        )
                                    }
                                }
                            }
                            ZStack {
                                // background for the meta button
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke()
                                    .frame(width: vm.expandTwo ? 300 : 290, height: vm.expandTwo ? 180 : 95)
                                    .foregroundColor(vm.metaButtonPressed ? Color.gray : cvm.homeBrew)
                                    .zIndex(5)
                                
                                // meta meditation link with a description of what meta is
                                if vm.metaButtonPressed == false {
                                    Button(action: {
                                        vm.metaButtonPressed = true
                                        vm.vipassanaButtonPressed = false
                                        vm.chosenMeditation = "Maitrī"
                                        vm.prompt = """
                                                You are a fully enlighten meta meditation trainer training people through an app. Provide me a non metaphysical meta meditation for an experienced meditator make. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                    }, label: {
                                        Text(vm.promptToggleTwo ? "Meta meditation is a meditation that cultivates compassion for oneself and others by reciting positive phrases and wishes." : "Maitrī")
                                            .foregroundColor(vm.metaButtonPressed ? Color.gray : cvm.homeBrew)
                                            .font(.system(size: vm.promptToggleTwo ? 14 : 30))
                                            .underline(false)
                                            .lineLimit(6)
                                            .padding(40)
                                        
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: vm.expandTwo ? 290 : 275, height: vm.expandTwo ? 150 : 65)
                                    .modifier(Shapes.NeumorphicRectangle())
                                    .cornerRadius(20)
                                    .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                                    .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
                                    .overlay(
                                        ZStack {
                                            // meta extra info icon that shows what type of meditation it is
                                            Button(action: {
                                            }, label: {
                                                Image(systemName: vm.expandTwo ? "minus.circle" : "i.circle").resizable().frame(width: 20, height: 20)
                                                    .foregroundColor(cvm.homeBrew)
                                                    .onTapGesture {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                            vm.expandTwo.toggle()
                                                            
                                                            if vm.expandTwo && vm.expand == true {
                                                                vm.expand = false
                                                                vm.promptToggle = false
                                                            }
                                                        }
                                                        vm.promptToggleTwo.toggle()
                                                    }
                                            })
                                            .buttonStyle(.borderless)
                                            .contentShape(Circle()
                                                .inset(by: -50))
                                            .buttonStyle(.borderless)
                                            .padding( .leading, vm.expandTwo ? 250 : 210)
                                        }
                                    )
                                    .zIndex(4)
                                } else {
                                    Button(action: {
                                        vm.metaButtonPressed.toggle()
                                    }, label: {
                                        Text("Maitrī")
                                            .font(.system(size: 25))
                                            .underline(false)
                                            .foregroundColor(Color.gray)
                                    })
                                    .buttonStyle(.borderless)
                                    .frame(width: 300, height: 95)
                                    .modifier(Shapes.NeumorphicBox())
                                    .overlay(
                                        ZStack {
                                            Button(action: {}, label: {
                                                Image(systemName: "i.circle").resizable().frame(width: 17, height: 17)
                                                    .foregroundColor(Color.gray)
                                                    .buttonStyle(.borderless)
                                            })
                                            .buttonStyle(.borderless)
                                        }
                                            .padding(.leading, 210)
                                    )
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        
                    }
                    .scaleEffect(0.9)
                    
                    ZStack {
                      
                        
                        VStack {
                            
                            Spacer(minLength: 30)
                            
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 350, height: vm.meditationTimeBoxExpand ? 350 : 170)
                                .foregroundColor(cvm.offBlack)
                                .modifier(Shapes.NeumorphicPopedOutBox())
                                .overlay(
                                    Button(action: {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                            vm.meditationTimeBoxExpand.toggle()
                                        }
                                    }, label: {
                                        Image(systemName: "i.circle").resizable() .frame(width: 20, height: 20)
                                            .foregroundColor(cvm.homeBrew)
                                            .padding(.top, vm.meditationTimeBoxExpand ? 303 : 100)
                                            .padding(.leading, vm.meditationTimeBoxExpand ? 290 : 270)
                                    })
                                    
                            )
                                .overlay(
                                    VStack {
                                       
                                        HStack(spacing: 0) {
                                            VStack {
                                                Text("DAYS:")
                                                    .scaleEffect(vm.meditationTimeBoxExpand ? 1 : 0)
                                                    .foregroundColor(cvm.homeBrew)
                                                    .padding(.top, 150)

                                                Rectangle()
                                                    .foregroundColor(cvm.offBlack)
                                                    .frame(width: vm.meditationTimeBoxExpand ? 155 : 0, height: vm.meditationTimeBoxExpand ? 100 : 0)
                                                    .modifier(Shapes.NeumorphicBox())
                                                    .overlay(
                                                    Text("999")
                                                        .scaleEffect(vm.meditationTimeBoxExpand ? 1 : 0)
                                                        .foregroundColor(cvm.homeBrew)
                                                    )
                                            }
                                            VStack {
                                                Text("HOURS:")
                                                    .scaleEffect(vm.meditationTimeBoxExpand ? 1 : 0)

                                                    .foregroundColor(cvm.homeBrew)
                                                    .padding(.top, 150)
                                                Rectangle()
                                                    .foregroundColor(cvm.offBlack)
                                                    .frame(width: vm.meditationTimeBoxExpand ? 155 : 0, height: vm.meditationTimeBoxExpand ? 100 : 0)
                                                    .modifier(Shapes.NeumorphicBox())
                                                    .overlay(
                                                    Text("999")
                                                        .scaleEffect(vm.meditationTimeBoxExpand ? 1 : 0)
                                                        .foregroundColor(cvm.homeBrew)
                                                    )
                                                
                                            }
                                            
                             
                                            
                                            
                                        }
                                    })
                        }
                        VStack {
                            HStack(spacing: 0) {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text(vm.chosenMeditation)
                                            .padding(.leading, 40)
                                            .padding(.trailing, 40)
                                            .frame(height: 80)
                                        
                                            .foregroundColor(cvm.homeBrew)
                                            .modifier(Shapes.NeumorphicBox())
                                    }
                                    Rectangle()
                                        .frame(width: 600, height: 1)
                                        .foregroundColor(cvm.homeBrew)
                                        .padding(.bottom, 80)
                                    
                                }
                                
                                VStack {
                                    
                                    Spacer()
                                    
                                    VStack {
                                        ZStack {
                                            
                                            Circle()
                                                .stroke()
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(cvm.homeBrew)
                                                .padding(.bottom, 30)
                                                .zIndex(3)
                                            
                                            NavigationLink(destination: MeditationGenerator(vm: vm), label: {
                                                Image(systemName: "figure.mind.and.body").resizable().frame(width: 40, height: 40)
                                                    .underline(false)
                                                    .foregroundColor(cvm.homeBrew)
                                            })
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
                                        Text(vm.chosenInstructor)
                                            .padding(.leading, 40)
                                            .padding(.trailing, 40)
                                            .frame(height: 80)
                                            .foregroundColor(cvm.homeBrew)
                                            .modifier(Shapes.NeumorphicBox())
                                        
                                        Spacer()
                                    }
                                    
                                    Rectangle()
                                        .frame(width: 600, height: 1)
                                        .foregroundColor(cvm.homeBrew)
                                        .padding(.bottom, 80)
                                    
                                }
                                
                            }
                            Spacer(minLength: vm.meditationTimeBoxExpand ? 150 : 0)
                        }
                        
                    }
                }
                .scaleEffect(0.9)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width:350, height: 400)
                        .foregroundColor(cvm.offBlack)
                        .modifier(Shapes.NeumorphicPopedOutBox())
                        .padding(.top, 50)
                    
                    VStack(spacing: 10) {
                        Spacer(minLength: 10)
                        ZStack {
                            HStack(content:  {
                                
                                // the label for choosing different instructors
                                Text("pick an instructer").padding()
                                    .underline(false)
                                    .buttonStyle(.borderless)
                                    .foregroundColor(cvm.homeBrew)
                                
                            })
                            .frame(width: 250, height: 70)
                            .cornerRadius(40)
                            .modifier(Shapes.NeumorphicBox())
                            .zIndex(7)
                            
                        }
                        HStack {
                            Grid(horizontalSpacing: vm.gridSpacing) {
                                GridRow {
                                    VStack(spacing: 10) {
                                        ZStack {
                                            //  green background for the Chief instructor
                                            
                                            RoundedRectangle(cornerRadius: vm.chiefButtonCornerSize)
                                                .stroke()
                                                .frame(width:  vm.chiefButtonBackgroundSize, height:  vm.chiefButtonBackgroundSize)
                                                .foregroundColor(vm.chiefButtonPressed ? Color.gray : cvm.homeBrew )
                                                .zIndex(2)
                                            if vm.chiefButtonPressed == false  {
                                                // Chief meditation instructor link with a description of how Chief will guid a meditation.
                                                Button(action: {
                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                        vm.lunaButtonPressed = false
                                                        vm.zeppelinButtonPressed = false
                                                        vm.maddieButtonPressed = false
                                                        vm.chiefButtonPressed.toggle()
                                                    }
                                                    vm.prompt = """
You are a fully enlighten vipassana meditation trainer, training people through an app. give me a non metaphysical meditation for a beginner meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                    vm.chosenInstructor = "Chief"
                                                }, label: {
                                                    Text(vm.chiefButton ? "Say hello to Chief, Chief is a well trained meditation instructor that is great at guiding beginners through an eyes closed meditation. Chief will connect you with the world using concepts found within your self." : "Chief")
                                                        .underline(false)
                                                        .foregroundColor(cvm.homeBrew)
                                                        .font(.system(size: vm.chiefButton ? 16 : 16))
                                                        .frame(width: vm.chiefButton ? 200 : 60, height: vm.chiefButton ? 200 : 20)
                                                    
                                                    
                                                })
                                                .disabled(vm.chiefButton)
                                                .buttonStyle(.borderless)
                                                .frame(width:  vm.chiefButtonSize, height: vm.chiefButtonSize)
                                                
                                                // nuemorphic design
                                                .modifier(Shapes.NeumorphicPopedOutBox())
                                                .overlay(
                                                    ZStack {
                                                        
                                                        // Chief extra info icon that shows what type of meditation this instructor does
                                                        Button(action: {
                                                        }, label: {
                                                            Image(systemName: vm.chiefButton ? "minus.circle" : "i.circle").resizable().frame(width: vm.chiefButtonIconSize, height: vm.chiefButtonIconSize)
                                                                .foregroundColor(cvm.homeBrew)
                                                                .onTapGesture {
                                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                        vm.lunaButtonPressed = false
                                                                        vm.zeppelinButtonPressed = false
                                                                        vm.maddieButtonPressed = false
                                                                        
                                                                        
                                                                        vm.chiefButton.toggle()
                                                                        
                                                                        if vm.chiefButton {
                                                                            vm.gridSpacing = 0
                                                                            
                                                                            vm.chiefButtonSize = 250
                                                                            vm.chiefButtonIconSize = 22
                                                                            vm.chiefButtonBackgroundSize = 270
                                                                            
                                                                            vm.zeppelinButtonSize = 0
                                                                            vm.zeppelinButtonIconSize = 0
                                                                            vm.zeppelinButtonBackgroundSize = 0
                                                                            vm.zeppelinButtonCornerSize = 100
                                                                            
                                                                            vm.lunaButtonSize = 0
                                                                            vm.lunaButtonIconSize = 0
                                                                            vm.lunaButtonBackgroundSize = 0
                                                                            vm.lunaButtonCornerSize = 100
                                                                            
                                                                            vm.maddieButtonSize = 0
                                                                            vm.maddieButtonIconSize = 0
                                                                            vm.maddieButtonBackgroundSize = 0
                                                                            vm.maddieButtonCornerSize = 100
                                                                        }  else {
                                                                            vm.gridSpacing = 10
                                                                            
                                                                            vm.zeppelinButtonSize = 120
                                                                            vm.zeppelinButtonIconSize = 15
                                                                            vm.zeppelinButtonBackgroundSize = 140
                                                                            vm.zeppelinButtonCornerSize = 30
                                                                            
                                                                            vm.chiefButtonSize = 120
                                                                            vm.chiefButtonIconSize = 15
                                                                            vm.chiefButtonBackgroundSize = 140
                                                                            vm.chiefButtonCornerSize = 30
                                                                            
                                                                            vm.lunaButtonSize = 120
                                                                            vm.lunaButtonIconSize = 15
                                                                            vm.lunaButtonBackgroundSize = 140
                                                                            vm.lunaButtonCornerSize = 30
                                                                            
                                                                            vm.maddieButtonSize = 120
                                                                            vm.maddieButtonIconSize = 15
                                                                            vm.maddieButtonBackgroundSize = 140
                                                                            vm.maddieButtonCornerSize = 30
                                                                        }
                                                                    }
                                                                }
                                                        })
                                                        
                                                        .contentShape(Circle()
                                                            .inset(by: -10))
                                                        .buttonStyle(.borderless)
                                                        .padding( .top, vm.chiefButton ? 200 : 70)
                                                        
                                                        
                                                    })
                                                
                                            } else if vm.chiefButtonPressed  {
                                                ZStack {
                                                    Button(action: {
                                                        
                                                        vm.chiefButtonPressed.toggle()
                                                    }, label: {
                                                        
                                                        Text("Chief")
                                                            .font(.system(size: 13))
                                                            .underline(false)
                                                            .foregroundColor(Color.gray)
                                                        
                                                        
                                                    })
                                                    .buttonStyle(.borderless)
                                                    .frame(width: 140, height: 140)
                                                    .modifier(Shapes.NeumorphicBox())
                                                    .overlay(
                                                        ZStack {
                                                            
                                                            // Maddie extra info icon that shows what type of meditation this instructor does
                                                            Button(action: {
                                                                vm.chiefButtonPressed.toggle()
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
                                            RoundedRectangle(cornerRadius: vm.lunaButtonCornerSize)
                                                .stroke()
                                                .frame(width: vm.lunaButtonBackgroundSize, height: vm.lunaButtonBackgroundSize)
                                                .foregroundColor(vm.lunaButtonPressed ? Color.gray : cvm.homeBrew )                                                .zIndex(6)
                                            
                                            
                                            if vm.lunaButtonPressed == false {
                                                // Luna meditation instructor link with a description of how Luna will guid a meditation.
                                                Button(action: {
                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                        vm.chiefButtonPressed = false
                                                        vm.zeppelinButtonPressed = false
                                                        vm.maddieButtonPressed = false
                                                        vm.lunaButtonPressed.toggle()
                                                    }
                                                    
                                                    vm.prompt = """
You are a fully enlighten vipassana meditation trainer training people through an app. Please create a non metaphysical meditation for experiencing nature; guide the person with all the moments of nature around them . Provide three dots: "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                    
                                                    vm.chosenInstructor = "Luna"
                                                }, label: {
                                                    Text(vm.lunaButton ? "Nurture yourself with nature. Go outside, Luna will guide you through a meditation that will connect you to the surroundings of nature.": "Luna")
                                                    
                                                        .underline(false)
                                                        .foregroundColor(cvm.homeBrew)
                                                        .font(.system(size: vm.lunaButton ? 20 : 17))
                                                        .frame(width: vm.lunaButton ? 200 : 50, height: vm.lunaButton ? 200 : 20)
                                                    
                                                })
                                                .disabled(vm.lunaButton)
                                                .buttonStyle(.borderless)
                                                .frame(width: vm.lunaButtonSize, height: vm.lunaButtonSize)
                                                
                                                
                                                
                                                
                                                .modifier(Shapes.NeumorphicPopedOutBox())
                                                .overlay(
                                                    ZStack {
                                                        
                                                        // Luna extra info icon that shows what type of meditation this instructor does
                                                        Button(action: {
                                                        }, label: {
                                                            Image(systemName: vm.lunaButton ? "minus.circle" : "i.circle").resizable().frame(width: vm.lunaButtonIconSize, height: vm.lunaButtonIconSize)
                                                                .foregroundColor(cvm.homeBrew)
                                                                .onTapGesture {
                                                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                        vm.chiefButtonPressed = false
                                                                        vm.zeppelinButtonPressed = false
                                                                        vm.maddieButtonPressed = false
                                                                        
                                                                        vm.lunaButton.toggle()
                                                                        if vm.lunaButton {
                                                                            vm.gridSpacing = 0
                                                                            
                                                                            vm.lunaButtonSize = 250
                                                                            vm.lunaButtonBackgroundSize = 270
                                                                            vm.lunaButtonIconSize = 22
                                                                            
                                                                            vm.chiefButtonSize = 0
                                                                            vm.chiefButtonIconSize = 0
                                                                            vm.chiefButtonBackgroundSize = 0
                                                                            vm.chiefButtonCornerSize = 100
                                                                            
                                                                            vm.maddieButtonSize = 0
                                                                            vm.maddieButtonIconSize = 0
                                                                            vm.maddieButtonBackgroundSize = 0
                                                                            vm.maddieButtonCornerSize = 100
                                                                            
                                                                            vm.zeppelinButtonSize = 0
                                                                            vm.zeppelinButtonIconSize = 0
                                                                            vm.zeppelinButtonBackgroundSize = 0
                                                                            vm.zeppelinButtonCornerSize = 100
                                                                            
                                                                        }  else {
                                                                            vm.gridSpacing = 10
                                                                            
                                                                            vm.lunaButtonSize = 120
                                                                            vm.lunaButtonIconSize = 15
                                                                            vm.lunaButtonBackgroundSize = 140
                                                                            vm.lunaButtonCornerSize = 30
                                                                            
                                                                            vm.zeppelinButtonSize = 120
                                                                            vm.zeppelinButtonIconSize = 15
                                                                            vm.zeppelinButtonBackgroundSize = 140
                                                                            vm.zeppelinButtonCornerSize = 30
                                                                            
                                                                            vm.chiefButtonSize = 120
                                                                            vm.chiefButtonIconSize = 15
                                                                            vm.chiefButtonBackgroundSize = 140
                                                                            vm.chiefButtonCornerSize = 30
                                                                            
                                                                            
                                                                            vm.maddieButtonSize = 120
                                                                            vm.maddieButtonIconSize = 15
                                                                            vm.maddieButtonBackgroundSize = 140
                                                                            vm.maddieButtonCornerSize = 30
                                                                        }
                                                                    }
                                                                }
                                                        })
                                                        .contentShape(Circle()
                                                            .inset(by: -10))
                                                        .buttonStyle(.borderless)
                                                        .padding( .top, vm.lunaButton ? 200 : 70)
                                                    })
                                            } else {
                                                ZStack {
                                                    Button(action: {
                                                        
                                                        vm.lunaButtonPressed.toggle()
                                                    }, label: {
                                                        
                                                        Text("Luna")
                                                            .font(.system(size: 13))
                                                            .underline(false)
                                                            .foregroundColor(Color.gray)
                                                        
                                                        
                                                    })
                                                    .buttonStyle(.borderless)
                                                    .frame(width: 140, height: 140)
                                                    .modifier(Shapes.NeumorphicBox())
                                                    .overlay(
                                                        ZStack {
                                                            
                                                            // Maddie extra info icon that shows what type of meditation this instructor does
                                                            Button(action: {
                                                                vm.lunaButtonPressed.toggle()
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
                                                RoundedRectangle(cornerRadius: vm.zeppelinButtonCornerSize )
                                                    .stroke()
                                                    .frame(width: vm.zeppelinButtonBackgroundSize, height: vm.zeppelinButtonBackgroundSize)
                                                    .foregroundColor(vm.zeppelinButtonPressed ? Color.gray : cvm.homeBrew )
                                                    .zIndex(6)
                                                
                                                if vm.zeppelinButtonPressed == false {
                                                    // Zeppelin meditation instructor link with a description of how Zeppelin will guid a meditation.
                                                    Button(action: {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                            vm.chiefButtonPressed = false
                                                            vm.lunaButtonPressed = false
                                                            vm.maddieButtonPressed = false
                                                            vm.zeppelinButtonPressed.toggle()
                                                        }
                                                        vm.prompt = """
You are a fully enlighten vipassana meditation trainer training people through an app. Please create me a non metaphysical meditation for an experienced meditator guiding the person with an eyes open meditation. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                        vm.chosenInstructor = "Zepp"
                                                    }, label: {
                                                        Text(vm.zeppelinButton ? "Zepp is an excellent teacher that guides a body awareness exercise. Wake yourself up, with Zeppelin meditation." :"Zepp")
                                                            .underline(false)
                                                            .foregroundColor(cvm.homeBrew)
                                                            .font(.system(size: vm.zeppelinButton ? 20 : 15))
                                                            .frame(width: vm.zeppelinButton ? 200 : 60, height: vm.zeppelinButton ? 200 : 20)
                                                        
                                                        
                                                    })
                                                    .disabled(vm.zeppelinButton)
                                                    .buttonStyle(.borderless)
                                                    .frame(width: vm.zeppelinButtonSize, height: vm.zeppelinButtonSize)
                                                    .modifier(Shapes.NeumorphicPopedOutBox())
                                                    .overlay(
                                                        ZStack {
                                                            
                                                            // Zeppelin extra info icon that shows what type of meditation this instructor does
                                                            Button(action: {
                                                            }, label: {
                                                                Image(systemName: vm.zeppelinButton ? "minus.circle" : "i.circle").resizable().frame(width: vm.zeppelinButtonIconSize, height: vm.zeppelinButtonIconSize)
                                                                    .foregroundColor(cvm.homeBrew)
                                                                    .onTapGesture {
                                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                            
                                                                            vm.chiefButtonPressed = false
                                                                            vm.lunaButtonPressed = false
                                                                            vm.maddieButtonPressed = false
                                                                            
                                                                            vm.zeppelinButton.toggle()
                                                                            if vm.zeppelinButton {
                                                                                vm.gridSpacing = 5
                                                                                
                                                                                vm.zeppelinButtonSize = 250
                                                                                vm.zeppelinButtonBackgroundSize = 270
                                                                                vm.zeppelinButtonIconSize = 22
                                                                                
                                                                                vm.chiefButtonSize = 0
                                                                                vm.chiefButtonIconSize = 0
                                                                                vm.chiefButtonBackgroundSize = 0
                                                                                vm.chiefButtonCornerSize = 100
                                                                                
                                                                                vm.lunaButtonSize = 0
                                                                                vm.lunaButtonIconSize = 0
                                                                                vm.lunaButtonBackgroundSize = 0
                                                                                vm.lunaButtonCornerSize = 100
                                                                                
                                                                                vm.maddieButtonSize = 0
                                                                                vm.maddieButtonIconSize = 0
                                                                                vm.maddieButtonBackgroundSize = 0
                                                                                vm.maddieButtonCornerSize = 100
                                                                            }  else {
                                                                                vm.gridSpacing = 10
                                                                                
                                                                                vm.zeppelinButtonSize = 120
                                                                                vm.zeppelinButtonIconSize = 15
                                                                                vm.zeppelinButtonBackgroundSize = 140
                                                                                vm.zeppelinButtonCornerSize = 30
                                                                                
                                                                                vm.chiefButtonSize = 120
                                                                                vm.chiefButtonIconSize = 15
                                                                                vm.chiefButtonBackgroundSize = 140
                                                                                vm.chiefButtonCornerSize = 30
                                                                                
                                                                                vm.lunaButtonSize = 120
                                                                                vm.lunaButtonIconSize = 15
                                                                                vm.lunaButtonBackgroundSize = 140
                                                                                vm.lunaButtonCornerSize = 30
                                                                                
                                                                                vm.maddieButtonSize = 120
                                                                                vm.maddieButtonIconSize = 15
                                                                                vm.maddieButtonBackgroundSize = 140
                                                                                vm.maddieButtonCornerSize = 30
                                                                            }
                                                                        }
                                                                    }
                                                            })
                                                            .contentShape(Circle()
                                                                .inset(by: -10))
                                                            .buttonStyle(.borderless)
                                                            .padding( .top, vm.zeppelinButton ? 200 : 70)
                                                        })
                                                } else {
                                                    ZStack {
                                                        Button(action: {
                                                            
                                                            vm.zeppelinButtonPressed.toggle()
                                                        }, label: {
                                                            
                                                            Text("Zepp")
                                                                .font(.system(size: 13))
                                                                .underline(false)
                                                                .foregroundColor(Color.gray)
                                                        })
                                                        .buttonStyle(.borderless)
                                                        .frame(width: 140, height: 140)
                                                        .modifier(Shapes.NeumorphicBox())
                                                        .overlay(
                                                            ZStack {
                                                                
                                                                // Maddie extra info icon that shows what type of meditation this instructor does
                                                                Button(action: {
                                                                    vm.zeppelinButtonPressed.toggle()
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
                                                RoundedRectangle(cornerRadius: vm.maddieButtonCornerSize)
                                                    .stroke()
                                                    .frame(width: vm.maddieButtonBackgroundSize, height: vm.maddieButtonBackgroundSize)
                                                    .foregroundColor(vm.maddieButtonPressed ? Color.gray : cvm.homeBrew )                                                    .zIndex(6)
                                                
                                                
                                                if vm.maddieButtonPressed == false {
                                                    // Maddie meditation instructor link with a description of how Maddie will guid a meditation.
                                                    Button(action: {
                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                            vm.chiefButtonPressed = false
                                                            vm.lunaButtonPressed = false
                                                            vm.zeppelinButtonPressed = false
                                                            vm.maddieButtonPressed.toggle()
                                                        }
                                                        vm.prompt = """
                                                    You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an experienced meditator, have the meditator feel the hart beating as the object of meditation for the practice. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                                                        vm.chosenInstructor = "Matil"
                                                    }, label: {
                                                        Text(vm.maddieButton ? "Feel the life of your hart, realizing the grounding nature of what makes your life...your life" : "Matil")
                                                            .underline(false)
                                                            .foregroundColor(cvm.homeBrew)
                                                            .font(.system(size: vm.maddieButton ? 20 : 15))
                                                            .frame(width: vm.maddieButton ? 200 : 60, height: vm.maddieButton ? 200 : 10)
                                                        
                                                    })
                                                    .disabled(vm.maddieButton)
                                                    .buttonStyle(.borderless)
                                                    .frame(width: vm.maddieButtonSize, height: vm.maddieButtonSize)
                                                    
                                                    // nuemorphic design
                                                    .modifier(Shapes.NeumorphicPopedOutBox())
                                                    .overlay(
                                                        ZStack {
                                                            
                                                            // Maddie extra info icon that shows what type of meditation this instructor does
                                                            Button(action: {
                                                            }, label: {
                                                                Image(systemName: vm.maddieButton ? "minus.circle" : "i.circle").resizable().frame(width: vm.maddieButtonIconSize, height: vm.maddieButtonIconSize)
                                                                    .foregroundColor(cvm.homeBrew)
                                                                    .onTapGesture {
                                                                        withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                                                            vm.chiefButtonPressed = false
                                                                            vm.lunaButtonPressed = false
                                                                            vm.zeppelinButtonPressed = false
                                                                            
                                                                            vm.maddieButton.toggle()
                                                                            
                                                                            if vm.maddieButton {
                                                                                vm.gridSpacing = 5
                                                                                
                                                                                vm.maddieButtonSize = 250
                                                                                vm.maddieButtonBackgroundSize = 270
                                                                                vm.maddieButtonIconSize = 22
                                                                                
                                                                                vm.chiefButtonSize = 0
                                                                                vm.chiefButtonIconSize = 0
                                                                                vm.chiefButtonBackgroundSize = 0
                                                                                vm.chiefButtonCornerSize = 100
                                                                                
                                                                                vm.lunaButtonSize = 0
                                                                                vm.lunaButtonIconSize = 0
                                                                                vm.lunaButtonBackgroundSize = 0
                                                                                vm.lunaButtonCornerSize = 100
                                                                                vm.lunaButtonIconSize = 0
                                                                                
                                                                                vm.zeppelinButtonSize = 0
                                                                                vm.zeppelinButtonBackgroundSize = 0
                                                                                vm.zeppelinButtonCornerSize = 100
                                                                            }  else {
                                                                                vm.gridSpacing = 10
                                                                                
                                                                                vm.maddieButtonSize = 120
                                                                                vm.maddieButtonIconSize = 15
                                                                                vm.maddieButtonBackgroundSize = 140
                                                                                vm.maddieButtonCornerSize = 30
                                                                                
                                                                                vm.zeppelinButtonSize = 120
                                                                                vm.zeppelinButtonIconSize = 15
                                                                                vm.zeppelinButtonBackgroundSize = 140
                                                                                vm.zeppelinButtonCornerSize = 30
                                                                                
                                                                                vm.chiefButtonSize = 120
                                                                                vm.chiefButtonIconSize = 15
                                                                                vm.chiefButtonBackgroundSize = 140
                                                                                vm.chiefButtonCornerSize = 30
                                                                                
                                                                                vm.lunaButtonSize = 120
                                                                                vm.lunaButtonIconSize = 15
                                                                                vm.lunaButtonBackgroundSize = 140
                                                                                vm.lunaButtonCornerSize = 30
                                                                            }
                                                                        }
                                                                    }
                                                            })
                                                            .contentShape(Circle()
                                                                .inset(by: -10))
                                                            .buttonStyle(.borderless)
                                                            .padding( .top, vm.maddieButton ? 200 : 70)
                                                        })
                                                    
                                                } else {
                                                    ZStack {
                                                        Button(action: {
                                                            
                                                            vm.maddieButtonPressed.toggle()
                                                        }, label: {
                                                            
                                                            Text("Matil")
                                                                .font(.system(size: 13))
                                                                .underline(false)
                                                                .foregroundColor(Color.gray)
                                                            
                                                            
                                                        })
                                                        .buttonStyle(.borderless)
                                                        .frame(width: 140, height: 140)
                                                        .modifier(Shapes.NeumorphicBox())
                                                        .overlay(
                                                            ZStack {
                                                                // Maddie extra info icon that shows what type of meditation this instructor does
                                                                Button(action: {
                                                                    vm.maddieButtonPressed.toggle()
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
                    .padding(.bottom, 20)
                }
                .scaleEffect(0.9)
                
                
                
                
                
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 350, height: 450)
                        .foregroundColor(cvm.offBlack)
                        .modifier(Shapes.NeumorphicPopedOutBox())

                    VStack {
                        ZStack {
                            HStack(content:  {
                                
                                // the label for describing the lesions section
                                Text("lessions").padding()
                                    .underline(false)
                                    .buttonStyle(.borderless)
                                    .foregroundColor(cvm.homeBrew)
                                
                            })
                            .frame(width: 160, height: 70)
                            .cornerRadius(40)
                            .modifier(Shapes.NeumorphicBox())
                            .zIndex(7)
                            
                           
                        }
                        Spacer(minLength: 100)

                    }
                    ZStack {
                        // green background for the text box
                        RoundedRectangle(cornerRadius: 30)
                            .stroke()
                            .frame(width: 355, height: 400)
                            .foregroundColor(cvm.homeBrew)
                            .zIndex(2)
                        ZStack {
                            VStack {
                                ScrollView {
                                    // The text that is generated for the lesions
                                    Text(vm.models.first ?? "")
                                        .position(x:140, y: 170)
                                        .frame(width: 280, height: 400)
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
                    }
                    .scaleEffect(0.9)
                    
                }
                    // status bar for audio
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
                    .scaleEffect(0.9)
                    
                    .padding(10)
                
                    VStack {
                        Spacer(minLength: 30)
                        
                        HStack(spacing: 40) {
                            // lession play button
                            NavigationLink(destination: MainMeditation(vm: vm), label: {
                                Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button
                                    .foregroundColor(cvm.homeBrew)
                                    .onTapGesture {
                                        vm.aiVoices(vm.models.first ?? "", withPause: 0.00)
                                    }
                            })
                            .buttonStyle(.borderless)
                            .frame(width: 150, height: 150)
                            
                            // nuemorphic design
                            .modifier(Shapes.NeumorphicCircle())
                            .zIndex(4)
                            // generate lesion button
                            Button(action: {
                                vm.prompt = "Teach me about vipassana meditation without waking me through a meditation."
                                vm.generatePrompt()
                            } ,
                                   label: {
                                // button icon for making a new meditation
                                Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                                    .foregroundColor(cvm.homeBrew)
                            })
                            
                            .scaleEffect(0.9)
                            
                            .buttonStyle(.borderless)
                            .frame(width: 150, height: 150)
                            .modifier(Shapes.NeumorphicPopedOutBox())
                            
                            .zIndex(4)
                        }
                    }
                }
                .frame(minWidth: 900, maxWidth: 1000, minHeight: 700, maxHeight: 2500)
                .background(LinearGradient (
                    
                    gradient: Gradient(colors: [cvm.offBlue, cvm.backgroundAppColor]),
                    startPoint: .top,
                    endPoint: .bottom))
                
            }
        }
    }

struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
