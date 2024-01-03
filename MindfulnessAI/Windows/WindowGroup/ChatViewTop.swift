//  ChatViewTop.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 11/15/23.
//
import SwiftUI
import RealmSwift
import Foundation
struct ChatViewTop: View {
    @ObservedObject var mode: Shapes
    @ObservedObject var vm = ViewModel()
    @StateObject var realm = LoginLogout()
    @ObservedObject var shapeVm = Shapes.shared
    @ObservedObject var viewModel = ChatViewModel.shared

    
    
    @ObservedRealmObject var group: BackendGroup
    let savedItems = Item.self

    
    @State var playing = true
    
    @State var pressedReset = true
    
    @State var startMeditation = true
    
    @State var gridSpacing: CGFloat = 10

    
    @State var vipassanaButtonPressed = true
    @State var expand: Bool = false
    @State var promptToggle: Bool = false
    
    @State var savedButtonPressed = false
    
    @State var metaButtonPressed = false
    @State var expandTwo: Bool = false
    @State var promptToggleTwo: Bool = false
    
    @State var expandThree: Bool = false
    @State var promptToggleThree: Bool = false
    @State var selfTimerButtonPressed = false

    
    @State var meditationTimeBoxAnimation = false
    @State var meditationTimeBoxExpand = false
    @State var menuPopUp = false
    @State var menuAnimationSizeChange = false
    
    @State var chiefButtonPressed: Bool = true
    @State var lunaButtonPressed: Bool = false
    @State var zeppelinButtonPressed: Bool = false
    @State var maddieButtonPressed: Bool = false
    
    var body: some View {
        
       ZStack {
           // the background for the vipassana, meta, and saved buttons
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("offBlack"))
                .frame(width: 350, height: expand || expandTwo || expandThree ? 535 : 450)
                .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                
            VStack(spacing: 20) {
                HStack(content:  {
                })
                // the label to pick a meditation
                Text("").padding()
                    .underline(false)
                    .buttonStyle(.borderless)
                    .frame(width: 230, height: 50)
                    .cornerRadius(40)
                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    .overlay(
                    Text("Choose a meditation")
                        .fontWeight(.thin)
                        .font(.system(size: 22))
                        .foregroundColor(Color("homeBrew"))

                    )
                
                // MARK: - Vipas Button
                ZStack {
                    // background for the vipassana button
                    RoundedRectangle(cornerRadius: 40)
                        .stroke()
                        .frame(width: expand ? 320 : 305, height: expand ? 180 : 95)  .foregroundColor(vipassanaButtonPressed ? Color("grayBlack") : Color("homeBrewSelect"))
                        .zIndex(5)
                    if vipassanaButtonPressed == false {
                        // vipassana meditation link with a description of what meta is
                        Button(action: {
                            savedButtonPressed = false
                            vipassanaButtonPressed = true
                            metaButtonPressed = false
                            viewModel.chosenMeditation = "Vipas"
                            chiefButtonPressed = true
                            viewModel.databaseAccess = false
                            viewModel.windowCase = false

                        }, label: {
                            // if the promptToggle is true show either the name of the meditation of the description of the mditaion
                            Text(promptToggle ? "Vipassanā is a way of self-transformation through self-observation by paying attention to ones physical sensations." : "Vipassanā")
                                .foregroundColor(Color("homeBrew"))
                                .fontWeight(.thin)
                                .font(.system(size: promptToggle ? 14 : 30))
                                .underline(false)
                                .lineLimit(6)
                                .padding(40)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: expand ? 290 : 275, height: expand ? 150 : 65)
                        .modifier(Shapes.NeumorphicRectangle(mode: mode))
                        .disabled(expand)
                        // the description of the meditation, so the AI will know what type of meditation to do.
                        .overlay(
                            ZStack {
                                // Vipassana extra info icon that shows what type of meditation it is
                                Button(action: {
                                    
                                }, label: {
                                    // the button within the button to show the description of what the meditation does
                                    Image(systemName: expand ? "minus.circle" : "i.circle").resizable().frame(width: 23, height: 23)
                                        .fontWeight(.thin)

                                        .foregroundColor(Color("homeBrew"))
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                expand.toggle()
                                                // If you expand to show the text in the meta button and the saved button, when click on the i-icon button it will collapse either the the meta or saved button
                                                if expand || expandThree {
                                                    expandTwo = false
                                                    expandThree = false
                                                    promptToggleTwo = false
                                                    promptToggleThree = false
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
                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    
                            .overlay(
                                ZStack {
                                        HStack {
                                            Text("Vipassanā")
                                                .fontWeight(.thin)
                                                .font(.system(size: 25))
                                                .font(.caption)
                                                .underline(false)
                                                .foregroundColor(Color("grayBlack"))
                                         
                                            Spacer()
                                                .frame(width: 40)
                                            
                                            // the clicked button within the button to show the description of what the meditation does
                                            Image(systemName: "i.circle").resizable().frame(width: 20, height: 20)
                                                .fontWeight(.thin)
                                                .foregroundColor(Color("grayBlack"))
                                        }
                            
                                    .buttonStyle(.borderless)
                                }
                                    .padding(.leading, 50)
                            )
                        }
                    }
                }
                // MARK: - Metta Button
                ZStack {
                    // background for the meta button
                    RoundedRectangle(cornerRadius: 40)
                        .stroke()
                        .frame(width: expandTwo ? 320 : 305, height: expandTwo ? 180 : 95)
                        .foregroundColor(metaButtonPressed ? Color("grayBlack") : Color("homeBrewSelect"))
                        .zIndex(5)
                    // meta meditation link with a description of what meta is
                    if metaButtonPressed == false {
                        Button(action: {
                            chiefButtonPressed = false
                            zeppelinButtonPressed = false
                            lunaButtonPressed = false
                            maddieButtonPressed = false
                            metaButtonPressed = true
                            savedButtonPressed = false
                            vipassanaButtonPressed = false
                            viewModel.databaseAccess = false
                            viewModel.windowCase = false

                            viewModel.chosenMeditation = "Maitrī"
                            vm.prompt = """
                                    You are a fully enlighten meta meditation trainer training people through an app. Provide me a non metaphysical meta meditation for an experienced meditator make. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
                        }, label: {
                            // if the promptToggleTwo is true show either the name of the meditation of the description of the mditaion
                            Text(promptToggleTwo ? "Meta meditation is a meditation that cultivates compassion for oneself and others by reciting positive phrases and wishes." : "Meta")
                                .fontWeight(.thin)
                                .foregroundColor(metaButtonPressed ? Color("grayBlack") : Color("homeBrew"))
                                .font(.system(size: promptToggleTwo ? 14 : 30))
                           
                                .underline(false)
                                .lineLimit(6)
                                .padding(40)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: expandTwo ? 290 : 275, height: expandTwo ? 150 : 65)
                        .cornerRadius(30)
                        .modifier(Shapes.NeumorphicRectangle(mode: mode))

                        .disabled(expandTwo)
                        .overlay(
                            ZStack {
                                // meta extra info icon that shows what type of meditation it is
                                Button(action: {
                                }, label: {
                                    // the button within the button to show the description of what the meditation does
                                    Image(systemName: expandTwo ? "minus.circle" : "i.circle").resizable().frame(width: 23, height: 23)
                                        .fontWeight(.thin)
                                        .foregroundColor(Color("homeBrew"))                                                    .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                expandTwo.toggle()
                                                // If you expand to show the text in the vipassana button and the saved button, when click on the i-icon button it will collapse either the the vipassana or saved button
                                                if expand || expandThree {
                                                    expand = false
                                                    expandThree = false
                                                    promptToggle = false
                                                    promptToggleThree = false
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
                        .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                        .overlay(
                            ZStack {
                                HStack {
                                    Text("Maitrī")
                                        .fontWeight(.thin)
                                        .font(.system(size: 25))
                                        .underline(false)
                                        .foregroundColor(Color("grayBlack"))
                                    Spacer()
                                        .frame(width: 60)
                                    
                                    // the clicked button within the button to show the description of what the meditation does
                                        Image(systemName: "i.circle").resizable().frame(width: 20, height: 20)
                                        .fontWeight(.thin)

                                            .foregroundColor(Color("grayBlack"))
                                            .buttonStyle(.borderless)
                                    
                                    
                                }
                            }
                                .padding(.leading, 80)
                        )
                        
                    }

                }
                
                // MARK: - Saved Button
                ZStack {
                    // background for the vipassana button
                    RoundedRectangle(cornerRadius: 40)
                        .stroke()
                        .frame(width: expandThree ? 320 : 305, height: expandThree ? 180 : 95)  .foregroundColor(                                        savedButtonPressed ? Color("grayBlack") : Color("homeBrewSelect"))
                        .zIndex(5)
                    if savedButtonPressed == false {
                        Button(action: {
                            vipassanaButtonPressed = false
                            savedButtonPressed = true
                            metaButtonPressed = false
                            viewModel.chosenMeditation = "Saved"
                            chiefButtonPressed = true
                            viewModel.databaseAccess = true
                            viewModel.windowCase = true
                        }, label: {
                            // if the expandThree is true show either the name of the meditation of the description of the mditaion
                            Text(expandThree ? "Pick from a list of saved meditations that you have found helpful." : "Saved")
                                .fontWeight(.thin)
                                .foregroundColor(Color("homeBrew"))
                                .font(.system(size: promptToggleThree ? 17 : 30))
                                .underline(false)
                                .lineLimit(6)
                                .padding(40)
                            
                        })
                        .buttonStyle(.borderless)
                        .frame(width: expandThree ? 290 : 275, height: expandThree ? 150 : 65)
                        .modifier(Shapes.NeumorphicRectangle(mode: mode))
                        .disabled(expandThree)
                        // the description of the meditation, so the AI will know what type of meditation to do.
                        .overlay(
                            ZStack {
                               
                                VStack {
                                    Spacer()
                                        .frame(height: 50)
                                
                                    Spacer()
                                        .frame(height: 50)
                                }
                                HStack {
                                // Vipassana extra info icon that shows what type of meditation it is
                                Button(action: {
                                    
                                }, label: {
                                    // the clicked button within the button to show the description of what the meditation does
                                    Image(systemName: expandThree ? "minus.circle" : "i.circle").resizable().frame(width: 23, height: 23)
                                        .fontWeight(.thin)
                                        .foregroundColor(Color("homeBrew"))
                                    
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.65)) {
                                                expandThree.toggle()
                                                
                                                // If you expand to show the text in the vipassana button and the meta button, when click on the i-icon button it will collapse either the the meta or vipassana button
                                                if expand || expandTwo  {
                                                    expand = false
                                                    expandTwo = false
                                                    promptToggle = false
                                                    promptToggleTwo = false

                                                }
                                            }
                                            promptToggleThree.toggle()
                                        }
                                    
                                    
                                })
                                
                                .buttonStyle(.borderless)
                             
                                .padding( .leading, expandThree ? 240 : 210)
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
                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                            
                            .overlay(
                                ZStack {
                                    HStack {
                                        Text("Saved")
                                            .fontWeight(.thin)
                                            .font(.system(size: 25))
                                            .underline(false)
                                            .foregroundColor(Color("grayBlack"))
                                        
                                        Spacer()
                                            .frame(width: 60)
                                        
                                        // the clicked button within the button to show the description of what the meditation does
                                        Image(systemName: "i.circle").resizable().frame(width: 20, height: 20)
                                            .fontWeight(.thin)
                                            .foregroundColor(Color("grayBlack"))
                                    }
                                    
                                    .buttonStyle(.borderless)
                                }
                                    .padding(.leading, 70)
                            )
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            
        }
       .scaleEffect(0.9)
    }
}

struct ContentView_Previews5: PreviewProvider {
    static var previews: some View {
        let group = BackendGroup()
        return Group {
            
            ChatView(mode: Shapes(), group: group)
        }
    }
}
