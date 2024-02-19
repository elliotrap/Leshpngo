//
//  ChatViewBottomMiddle.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 11/15/23.
//
import SwiftUI
import RealmSwift
import Foundation
// MARK: - Chat View Bottom Middle
struct ChatViewBottomMiddle: View {
    
    @ObservedObject var mode: Shapes
    @ObservedObject var vm = ViewModel()
    @ObservedObject var shapeVm = Shapes.shared
    @ObservedObject var viewModel = ChatViewModel.shared

    @ObservedRealmObject var group: BackendGroup
    let savedItems = Item.self
    
    @State var playing = true
    
    @State var pressedReset = true
    
    @State var startMeditation = true
    
    @State var gridSpacing: CGFloat = 10

    
    @State var metaButtonPressed = false
    
    @State var vipassanaButtonPressed = true
    
    @State var selfTimerButtonPressed = false

    
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
       ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width:350, height: 420)
                .foregroundColor(Color("offBlack"))
                .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                .padding(.top, 0)
            
            VStack(spacing: 15) {
                ZStack {
                    HStack(content:  {
                        
                        // the label for choosing different instructors
                  Text("")
                 
                            
                    })
                    .frame(width: 220, height: 50)
                    .cornerRadius(40)
                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    .overlay(
                    Text("pick an instructer")
                        .fontWeight(.thin)

                        .font(.system(size: 22))
                        .underline(false)
                        .foregroundColor(Color("homeBrew"))
                    )
                    .zIndex(7)
                }
                HStack {
                    Grid(horizontalSpacing: gridSpacing) {
                        GridRow {
                            VStack(spacing: 10) {
                                ZStack {
                                    //  green background for the Chief instructor
                                    // MARK: - Chief

                                    RoundedRectangle(cornerRadius: chiefButtonCornerSize)
                                        .stroke()
                                        .frame(width:  chiefButtonBackgroundSize, height:  chiefButtonBackgroundSize)
                                        .foregroundColor(chiefButtonPressed ? Color("grayBlack") : Color("homeBrewSelect") )
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
                                            viewModel.chosenInstructor = "Chief"
                                        }, label: {
                                            Text(chiefButton ? "Say hello to Chief, Chief is a well trained meditation instructor that is great at guiding beginners through an eyes closed meditation. Chief will connect you with the world using concepts found within your self." : "Chief")
                                                .underline(false)
                                                .foregroundColor(Color("homeBrew"))
                                                .font(.system(size: chiefButton ? 16 : 21))
                                                .fontWeight(.thin)
                                                .frame(width: chiefButton ? 200 : 60, height: chiefButton ? 200 : 20)
                                        })
                                        .disabled(chiefButton)
                                        .buttonStyle(.borderless)
                                        .frame(width:  chiefButtonSize, height: chiefButtonSize)
                                        // nuemorphic design
                                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                        .overlay(
                                            ZStack {
                                                // Chief extra info icon that shows what type of meditation this instructor does
                                                Button(action: {
                                                }, label: {
                                                    Image(systemName: chiefButton ? "minus.circle" : "i.circle").resizable().frame(width: chiefButtonIconSize, height: chiefButtonIconSize)
                                                        .fontWeight(.thin)
                                                        .foregroundColor(Color("homeBrew"))
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
                                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                            .overlay(
                                                ZStack {
                                                    // Maddie extra info icon that shows what type of meditation this instructor does
                                                    
                                                    Text("Chief")
                                                        .font(.system(size: 18))
                                                        .fontWeight(.thin)
                                                        .underline(false)
                                                        .foregroundColor(Color("grayBlack"))
                                                    
                                                    Button(action: {
                                                    }, label: {
                                                        Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                            .fontWeight(.thin)

                                                            .foregroundColor(Color("grayBlack"))
                                                    })
                                                    .buttonStyle(.borderless)
                                                    .padding(.top, 70)
                                                    .onAppear {
                                                        viewModel.currentInput = """
                                              You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an beginner meditator. Provide a plus sign with a 2 which looks like this "+2" to identify a pause for silence after each section; let there be five and only 5 "2+" in the meditation, each pause (+2) is 2 minutes so the meditation will last 10 minutes. Add a lot of emphasis in the punctuation to make the meditation sound more dramatic. Also please don't number each section of the meditation.
"""
                                                        viewModel.contentMessage = """
                                              Please provide a meditation lesson for a beginner. Remember to use the "+2" key to signify a pause.
                                              """}
                                            }
                                        )}
                                    }
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: lunaButtonCornerSize)
                                        .stroke()
                                        .frame(width: lunaButtonBackgroundSize, height: lunaButtonBackgroundSize)
                                        .foregroundColor(lunaButtonPressed ? Color("grayBlack") : Color("homeBrewSelect") ) .zIndex(6)
                                    if lunaButtonPressed == false {
                                        // Luna meditation instructor link with a description of how Luna will guid a meditation.
                                        // MARK: - Luna button

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
                                            
                                            viewModel.chosenInstructor = "Luna"
                                        }, label: {
                                            Text(lunaButton ? "Nurture yourself with nature. Go outside, Luna will guide you through a meditation that will connect you to the surroundings of nature.": "Luna")
                                            
                                                .underline(false)
                                                .foregroundColor(Color("homeBrew"))
                                                .font(.system(size: lunaButton ? 20 : 21))
                                                .fontWeight(.thin)

                                                .frame(width: lunaButton ? 200 : 50, height: lunaButton ? 200 : 20)
                                            
                                        })
                                        .disabled(lunaButton)
                                        .buttonStyle(.borderless)
                                        .frame(width: lunaButtonSize, height: lunaButtonSize)
                                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                        .overlay(
                                            ZStack {
                                                
                                                // Luna extra info icon that shows what type of meditation this instructor does
                                                Button(action: {
                                                }, label: {
                                                    Image(systemName: lunaButton ? "minus.circle" : "i.circle").resizable().frame(width: lunaButtonIconSize, height: lunaButtonIconSize)
                                                        .fontWeight(.thin)
                                                        .foregroundColor(Color("homeBrew"))
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
                                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                            .overlay(
                                                ZStack {
                                                    // Maddie extra info icon that shows what type of meditation this instructor does
                                                    Text("Luna")
                                                        .font(.system(size: 18))
                                                        .fontWeight(.thin)

                                                        .underline(false)
                                                        .foregroundColor(Color("grayBlack"))
                                                    
                                                    Button(action: {
                                                    }, label: {
                                                        Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                            .fontWeight(.thin)
                                                            .foregroundColor(Color("grayBlack"))
                                                    })
                                                    .buttonStyle(.borderless)
                                                    .padding(.top, 70)
                                                    .onAppear {
                                                        viewModel.currentInput = """
                                              You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an experienced meditator, have the meditator go outside or play the sounds of nature though a speaker. Provide a plus sign "+" with a two "2" which looks like this: "+2" to identify a pause for silence after each section; let there be five and only 5 pauses (2+) in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Add a lot of emphasis in the punctuation to make the meditation sound more dramatic by adding a lot of "--" and ",". Also don't number each section of the meditation.
"""
                                                        viewModel.contentMessage = """
                                              Provide a meditation that walks the meditator though an outdoor meditation experience.
                                              """}
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
                                            .foregroundColor(zeppelinButtonPressed ? Color("grayBlack") : Color("homeBrewSelect") )
                                            .zIndex(6)
                                        
                                        if zeppelinButtonPressed == false {
                                            // Zeppelin meditation instructor link with a description of how Zeppelin will guid a meditation.
                                            // MARK: - Zepp Button

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
                                                viewModel.chosenInstructor = "Zepp"
                                            }, label: {
                                                Text(zeppelinButton ? "Zepp is an excellent teacher that guides a body awareness exercise. Wake yourself up, with Zeppelin meditation." :"Zepp")
                                                    .underline(false)
                                                    .foregroundColor(Color("homeBrew"))
                                                    .font(.system(size: zeppelinButton ? 20 : 21))
                                                    .fontWeight(.thin)
                                                    .frame(width: zeppelinButton ? 200 : 60, height: zeppelinButton ? 200 : 20)
                                            })
                                            .disabled(zeppelinButton)
                                            .buttonStyle(.borderless)
                                            .frame(width: zeppelinButtonSize, height: zeppelinButtonSize)
                                            .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                            .overlay(
                                                ZStack {
                                                    // Zeppelin extra info icon that shows what type of meditation this instructor does
                                                    Button(action: {
                                                    }, label: {
                                                        Image(systemName: zeppelinButton ? "minus.circle" : "i.circle").resizable().frame(width: zeppelinButtonIconSize, height: zeppelinButtonIconSize)
                                                            .fontWeight(.thin)
                                                            .foregroundColor(Color("homeBrew"))
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
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                                .overlay(
                                                    ZStack {
                                                        
                                                        // Maddie extra info icon that shows what type of meditation this instructor does
                                                        Text("Zepp")
                                                            .font(.system(size: 18))
                                                            .fontWeight(.thin)
                                                            .underline(false)
                                                            .foregroundColor(Color("grayBlack"))
                                                        
                                                        Button(action: {
                                                        }, label: {
                                                            Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                                .fontWeight(.thin)
                                                                .foregroundColor(Color("grayBlack"))
                                                        })
                                                        .buttonStyle(.borderless)
                                                        .padding(.top, 70)
                                                        .onAppear {
                                                            viewModel.currentInput = """
                                                  You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an experienced meditator, have the meditator do a body scan meditation. Provide a plus sign "+" with a two "2" which looks like this: "+2" to identify a pause for silence after each section; let there be five and only 5 pauses (2+) in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Add a lot of emphasis in the punctuation to make the meditation sound more dramatic by adding a lot of "--" and ",". Also don't number each section of the meditation.
"""
                                                            viewModel.contentMessage = """
                                                  Please provide a body scan meditation. Remember to use the "+2" key to signify a pause.
                                                  """}
                                                }
                                            )}
                                        }
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerRadius: maddieButtonCornerSize)
                                            .stroke()
                                            .frame(width: maddieButtonBackgroundSize, height: maddieButtonBackgroundSize)
                                            .foregroundColor(maddieButtonPressed ? Color("grayBlack") : Color("homeBrewSelect"))                                                    .zIndex(6)
                                        if maddieButtonPressed == false {
                                            // Maddie meditation instructor link with a description of how Maddie will guid a meditation.
                                            // MARK: - Matil Button

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
                                            You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an experienced meditator, have the meditator feel the hart beating as the object of meditation for the practice. Provide a plus sign "+" with a two "2" which looks like this: "+2" to identify a pause for silence after each section; let there be five and only 5 pauses (2+) in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Add a lot of emphasis in the punctuation to make the meditation sound more dramatic by adding a lot of "--" and ",". Also don't number each section of the meditation.
"""
                                                viewModel.chosenInstructor = "Matil"
                                            }, label: {
                                                Text(maddieButton ? "Feel the life of your hart, realizing the grounding nature of what makes your life...your life" : "Matil")
                                                    .underline(false)
                                                    .foregroundColor(Color("homeBrew"))
                                                    .font(.system(size: maddieButton ? 20 : 21))
                                                    .fontWeight(.thin)

                                                    .frame(width: maddieButton ? 200 : 60, height: maddieButton ? 200 : 10)
                                                
                                            })
                                            .disabled(maddieButton)
                                            .buttonStyle(.borderless)
                                            .frame(width: maddieButtonSize, height: maddieButtonSize)
                                            // nuemorphic design
                                            .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                            .overlay(
                                                ZStack {
                                                    // Maddie extra info icon that shows what type of meditation this instructor does
                                                    Button(action: {
                                                    }, label: {
                                                        Image(systemName: maddieButton ? "minus.circle" : "i.circle").resizable().frame(width: maddieButtonIconSize, height: maddieButtonIconSize)
                                                            .fontWeight(.thin)

                                                            .foregroundColor(Color("homeBrew"))
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
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                  
                                                .overlay(
                                                    ZStack {
                                                        // Maddie extra info icon that shows what type of meditation this instructor does
                                                        Text("Matil")
                                                            .font(.system(size: 18))
                                                            .fontWeight(.thin)
                                                            .underline(false)
                                                            .foregroundColor(Color("grayBlack"))
                                                        
                                                        Button(action: {
                                                        }, label: {
                                                            Image(systemName: "i.circle").resizable().frame(width: 13, height: 13)
                                                                .fontWeight(.thin)
                                                                .foregroundColor(Color("grayBlack"))
                                                        })
                                                        .buttonStyle(.borderless)
                                                        .padding(.top, 70)
                                                        .onAppear {
                                                            viewModel.currentInput = """
                                                  You are a fully enlighten vipassana meditation trainer training people through an app. Please conjure up a non metaphysical meditation for an experienced meditator, have the meditator feel the hart beating as the object of meditation for the practice. Provide a plus sign "+" with a two "2" which looks like this: "+2" to identify a pause for silence after each section; let there be five and only 5 pauses (2+) in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Add a lot of emphasis in the punctuation to make the meditation sound more dramatic by adding a lot of "--" and ",". Also don't number each section of the meditation.
"""
                                                            viewModel.contentMessage = """
                                                  Provide a meditation lesson that guides you to feel the beating of your hart. Remember to use the "+2" key to signify a pause.
                                                  """}
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
        

    }
}

#Preview {
    let group = BackendGroup()
    return Group {
        
        ChatView(mode: Shapes(), group: group)
    }
}

