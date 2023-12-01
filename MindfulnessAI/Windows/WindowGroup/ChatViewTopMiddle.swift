
//
//  ChatViewTopMiddle.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 11/15/23.
//
import SwiftUI
import RealmSwift
import Foundation



// MARK: - Chat View Top Middle
struct ChatViewTopMiddle: View {
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes.shared
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    
    @ObservedRealmObject var group: BackendGroup
    
    @State var isNavigationActive = false

   
    @State var tenMinuetButton = true
    @State var twentyMinuetButton = false
    @State var thirtyMinuetButton = false
    
    @State var startMeditation = true
       
    @State private var chosenMeditation = "Vipas"
    @State private var chosenInstructor = "Chief"
    
    @State private var meditationTimeBoxAnimation: Bool = false
    @State private var meditationTimeBoxExpand: Bool = false
    @State private var menuPopUp: Bool = false
    @State private var menuAnimationSizeChange: Bool = false
    
    
    var body: some View {
       ZStack {
            ZStack {
                Spacer(minLength: 20)
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350, height: meditationTimeBoxAnimation || menuAnimationSizeChange ? 400 : 170)
                    .foregroundColor(Color("offBlack"))
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                    .animation(.spring(response: 1, dampingFraction: 1), value: meditationTimeBoxAnimation)
                    .overlay(
                 
                        
                        HStack(spacing: (meditationTimeBoxExpand || menuPopUp) ? 40 : 150) {
                            // Plus icon used for expanding the meditation time selection
                            // The icon's size becomes zero when either meditationTimeBoxExpand or menuPopUp is true
                            Image(systemName:"plus").resizable()
                                .frame(width: meditationTimeBoxExpand || menuPopUp ? 0 : 30, height: meditationTimeBoxExpand || menuPopUp ? 0 : 30)
                                .fontWeight(.thin)
                                .foregroundColor(Color("homeBrew"))
                                // Adjusts the top padding based on the state of meditationTimeBoxExpand or menuPopUp
                                .padding(.top, meditationTimeBoxExpand || menuPopUp ? 310 : 100)
                                .onTapGesture {
                                    // Toggles the state of meditationTimeBoxExpand and triggers an animation when tapped
                                    meditationTimeBoxExpand.toggle()
                                    withAnimation(.spring(response: 1, dampingFraction: 1)) {
                                        meditationTimeBoxAnimation.toggle()
                                    }
                                }
                                // Adjusts the overall padding based on the state of meditationTimeBoxExpand or menuPopUp
                                .padding(meditationTimeBoxExpand || menuPopUp ? 50 : 0)
                            
                            // Conditionally displayed chevron-up icon shown only when meditationTimeBoxExpand or menuPopUp is true
                            if meditationTimeBoxExpand || menuPopUp {
                                Image(systemName: "chevron.up").resizable()
                                    .fontWeight(.thin)
                                    .frame(width: 100, height: 20)
                                    .foregroundColor(Color("homeBrewSelect"))
                                    // Adjusts the top padding based on the state of meditationTimeBoxExpand or menuPopUp
                                    .padding(.top, meditationTimeBoxExpand || menuPopUp ? 340 : 100)
                                    .onTapGesture {
                                        // Resets multiple state variables when tapped, collapsing and resetting the UI
                                        withAnimation(.spring(response: 1, dampingFraction: 0.6)) {
                                            menuPopUp = false
                                            meditationTimeBoxExpand = false
                                            menuAnimationSizeChange = false
                                            meditationTimeBoxAnimation = false
                                            viewModel.profileButtonPressed = false
                                            viewModel.durationButtonPressed = false
                                        }
                                    }
                                    // Adjusts the overall padding based on the state of meditationTimeBoxExpand or menuPopUp
                                    .padding(meditationTimeBoxExpand || menuPopUp ? 50 : 0)
                            }
                        

                                        // The icon for expanding the menu if meditationTimeBoxExpand or menuPopUp is true
                                        Image(systemName: "line.3.horizontal").resizable()
                                            .frame(width: meditationTimeBoxExpand || menuPopUp ? 0 : 30, height: meditationTimeBoxExpand || menuPopUp ? 0 : 20)
                                            .fontWeight(.thin)

                                            .foregroundColor(Color("homeBrew"))
                                            .padding(.top, meditationTimeBoxExpand || menuPopUp ? 310 : 100)
                                            .onTapGesture {
                                                withAnimation(.spring(response: 1, dampingFraction: 1)) {
                                                    menuPopUp.toggle()
                                                    menuAnimationSizeChange.toggle()
                                                }
                                            }
                                            .padding(meditationTimeBoxExpand || menuPopUp ? 50 : 0)
                                        
                                    }
                             
                                )
                        
                
                // MARK: - Menu
                    .overlay(
                        HStack {
                            if viewModel.profileButtonPressed == false && viewModel.durationButtonPressed == false {
                            
                            ZStack {
                                VStack {
                                    Spacer()
                                        .frame(height: 120)
                                    
                                    // The structure for the logout and the profile buttons
                                    logOutAndProfileButton(mode: Shapes(), group: group)
                                    Spacer()
                                        .frame(height: 30)
                                        .zIndex(1)
                                    // The structure for the duration and the dark mode buttons
                                    darkModeDurationButtons(mode: Shapes(), group: group)
                                        .zIndex(0)
                                }
                            }
                                    
                             

                                

                            } else if viewModel.profileButtonPressed {
                                    // MARK: - Password Change

                                    HStack {
                                        
                                        VStack {
                                            
                                            Spacer()
                                                .frame(height: 120)
                                            // if the profile button was clicked display the username
                                            Text("Username")
                                                .fontWeight(.thin)
                                                .font(.system(size: 15))
                                                .frame(width: 150)
                                                .foregroundColor(Color("homeBrew"))
                                            
                                            Button(action: {}, label: {
                                                Text("")
                                            })
                                            .frame(width: 200, height: 40)
                                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                            // if the profile button was clicked display the password
                                            Text("Password")
                                                .fontWeight(.thin)
                                                .font(.system(size: 15))
                                                .frame(width: 150)
                                                .foregroundColor(Color("homeBrew"))
                                            
                                            Button(action: {}, label: {
                                                Text("")
                                                
                                            })
                                            .frame(width: 200, height: 40)
                                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                        }
                                   
                                        
                                    }
                                } else if viewModel.durationButtonPressed {
                                    // MARK: - 10 min / 20 min
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke()
                                            .frame(width: 300, height: 150)
                                            .foregroundColor(Color("homeBrewSelect"))
                                            .zIndex(6)
                                        
                                        
                                        HStack {
                                            
                                            // The buttons that get toggled based off of weather you clicked the 10 min or 20 min button
                                            if tenMinuetButton == false {
                                                Button(action: {
                                                    tenMinuetButton = true
                                                twentyMinuetButton = false
                                                },
                                                       label: {
                                                    Text("10 min")
                                                        .fontWeight(.thin)
                                                        .underline(false)
                                                        .foregroundStyle(Color("homeBrew"))
                                                    
                                                })
                                                .buttonStyle(.borderless)
                                                .frame(width: 130, height: 130)
                                                .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                                .zIndex(tenMinuetButton ? 1 : 2)
                                                
                                            } else {
                                                // The clicked 10 min button that get toggled based off of weather you clicked the 10 min or 20 min button

                                                Button(action: {
                                                }, label: {
                                                    
                                                    
                                                })
                                                .buttonStyle(.borderless)
                                                .frame(width: 130, height: 130)
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                                .zIndex(tenMinuetButton ? 2 : 1)
                                                
                                                .overlay(
                                                    Text("10 min")
                                                        .fontWeight(.thin)
                                                        .foregroundColor(Color.gray)
                                                        .underline(false)
                                                        .foregroundStyle(Color("homeBrew"))
                                                )
                                            }
                                            if twentyMinuetButton == false {
                                                // The button that get toggled based off of weather you clicked the 10 min or 20 min button
                                                Button(action: {
                                                    twentyMinuetButton = true
                                                    tenMinuetButton = false
                                                },
                                                       label: {
                                                    Text("20 min")
                                                        .underline(false)
                                                        .foregroundStyle(Color("homeBrew"))
                                                    
                                                })
                                                .buttonStyle(.borderless)
                                                .frame(width:130, height: 130)
                                                .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                            } else {
                                                // The clicked 20 min button that get toggled based off of weather you clicked the 10 min or 20 min button
                                                Button(action: {
                                                }, label: {
                                                    
                                                    
                                                })
                                                .buttonStyle(.borderless)
                                                .frame(width: 130, height: 130)
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                                .zIndex(tenMinuetButton ? 2 : 1)
                                                .overlay(
                                                    Text("20 min")
                                                        .foregroundColor(Color.gray)
                                                        .underline(false)
                                                        .foregroundStyle(Color("homeBrew"))
                                                )
                                            }
                                        }
                                    }
                                    .padding(.top, 120)
                                }
                            }
                            .scaleEffect(menuPopUp ? 1 : 0)



                    )
            
                // MARK: - Time Display
                    .overlay(
                      
                        VStack {
                            LazyHStack(spacing: 20) {
                            
                                        LazyVStack {
                                            // The hours text box that gets displayed based off if you click the plus icon
                                            Text("HOURS:")
                                                .scaleEffect(meditationTimeBoxAnimation ? 1 : 0)
                                                .animation(.spring(response: 1, dampingFraction: 1), value: menuPopUp)

                                                .foregroundColor(Color("homeBrew"))
                                                .padding(.top, 130)
                                            Rectangle()
                                                .foregroundColor(Color("offBlack"))
                                                .frame(width: meditationTimeBoxAnimation ? 220 : 0, height: meditationTimeBoxAnimation ? 100 : 0)
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                                .overlay(
                                                    Text(viewModel.formatTotalDuration())
                                                         .scaleEffect(meditationTimeBoxAnimation ? 2 : 0)
                                                         .animation(.spring(response: 2, dampingFraction: 1), value: menuPopUp)

                                                        .foregroundColor(Color("homeBrew"))
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
                                Text("               ").padding()
                                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                    .padding(.leading, 0)
                                    .padding(.trailing, 0)
                                    .frame(height: 60)
                                    .overlay(
                                        // The chosen meditation that the user has clicked
                                        Text(chosenMeditation)
                                            .fontWeight(.thin)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color("homeBrew"))

                                    )
                                
                                Spacer()
                                    .frame(height: 15)
                            }
                        }
                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: 120, height: 0.66)
                                .foregroundColor(Color("homeBrewSelect"))
                                .padding(.bottom, 80)
                            Rectangle()
                                .frame(width: 120, height: 1)
                                .foregroundColor(Color("homeBrewSelect"))
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
                                    .foregroundColor(Color("homeBrewSelect"))
                                    .padding(.bottom, 30)
                                    .zIndex(3)
                                // MARK: - lesson play button
                                // the navigation link for when the user has clicked on a meditation
                                
                                NavigationLink(destination: viewModel.databaseAccess ? AnyView(MainMeditation(mode: Shapes(), group: group)) : AnyView(MeditationGenerator( mode: Shapes(), group: group))
                               , label: {

                                                                   Image(systemName: "figure.mind.and.body").resizable().frame(width: 40, height: 40)

                                                                           .underline(false)
                                                                           .foregroundColor(Color("homeBrew"))

                                                            
                                                                   })
                                                                   .onAppear {
                                                                       viewModel.databaseAccess = false
                                                                       }
                                                                   .buttonStyle(.borderless)
                                                                   .frame(width: 80, height: 80)
                                                                   .modifier(Shapes.NeumorphicCircle(mode: mode))
                                                                   .padding(.bottom, 30)
                                                           
                                                       
                                                   
                    
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        HStack {
                            VStack {
                
                                Text("            ").padding()
                                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                    .padding(.leading, 0)
                                    .padding(.trailing, 0)
                                    .frame(height: 60)
                                    .overlay(
                                        // The chosen instructor that the user has chosen
                                        Text(chosenInstructor)
                                            .fontWeight(.thin)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color("homeBrew"))

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
                                .foregroundColor(Color("homeBrewSelect"))
                                .padding(.bottom, 80)
                            Rectangle()
                                .frame(width: 120, height: 0.66)
                                .foregroundColor(Color("homeBrewSelect"))
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
    
}


struct darkModeDurationButtons: View {
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes.shared
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    
    @ObservedRealmObject var group: BackendGroup

    var body: some View {
        HStack {
            // The button that toggles an if statement that displays the 10 and 20 minuet button based off durationButtonPressed being true
            Button(action: {
                viewModel.durationButtonPressed = true
            }, label: {
                HStack {
                    Text("Duration")
                        .fontWeight(.thin)
                        .underline(true)
                        .font(.system(size: 15))
                        .foregroundColor(Color("homeBrew"))
                    
                    Image(systemName: "clock")
                        .foregroundColor(Color("homeBrew"))
                }
            })
            .buttonStyle(.borderless)
            .frame(width: 120, height: 70)
            .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
            
            Spacer()
                .frame(width: 30)
            
            if shapeVm.darkmode {
                // MARK: - light mode / dark mode
                // The dark and light mode buttons that are displayed based off if shapeVm.darkmode is true of false
                Button(action: {
                    shapeVm.darkmode = false
                    mode.changeMode = false
                }, label: {
                    HStack {
                        Text("Lightmode")
                            .fontWeight(.thin)
                            .underline(true)
                            .font(.system(size: 15))
                            .foregroundColor(Color("homeBrew"))
                        
                        Image(systemName: "sun.haze")
                            .foregroundColor(Color("homeBrew"))
                    }
                    
                })
                .buttonStyle(.borderless)
                .frame(width: 120, height: 70)
                .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))


            } else {
                // the dark mode button with a toggle to change modes
                Button(action: {
                }, label: {
        
                    
                })
                .buttonStyle(.borderless)
                .frame(width: 120, height: 70)
                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                .onTapGesture {
                    shapeVm.darkmode = true
                    mode.changeMode = true

                }
                .overlay(
                    HStack {
                    Text("darkmode")
                        .fontWeight(.thin)
                        .underline(true)
                        .font(.system(size: 13))
                        .foregroundColor(Color("homeBrew"))

                    Image(systemName: "moon.stars")
                            .font(.system(size: 11.8))
                        .foregroundColor(Color("homeBrew"))


                }
            )

            }
            
        }
    }
}

struct logOutAndProfileButton: View {
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes.shared
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    
    @ObservedRealmObject var group: BackendGroup
    
    @State var tenMinuetButton = true
    @State var twentyMinuetButton = false
    @State var thirtyMinuetButton = false
    
    @State var startMeditation = true
    


    var body: some View {
        
        HStack {
            // If the user clicks this button it logs them out calling the realm.logout function
            Button(action: {
                realm.logout()
            }, label: {
                HStack {
                    Text("Logout")
                        .fontWeight(.thin)
                        .underline(true)
                        .font(.system(size: 15))
                        .foregroundColor(Color("homeBrew"))
                    Image(systemName: "pip.exit")
                        .foregroundColor(Color("homeBrew"))
                    
                }
            })
            .buttonStyle(.borderless)
            .frame(width: 120, height: 70)
            .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
            
            Spacer()
                .frame(width: 30)
            // If you press this button it displays the username information
            Button(action: {
                viewModel.profileButtonPressed = true
            }, label: {
                HStack {
                    Text("Profile")
                        .fontWeight(.thin)
                        .underline(true)
                        .font(.system(size: 15))
                        .foregroundColor(Color("homeBrew"))
                    Image(systemName: "person")
                        .foregroundColor(Color("homeBrew"))
                    
                }
                
            })
            .buttonStyle(.borderless)
            .frame(width: 120, height: 70)
            .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
            
            
        }
    }
}
struct ContentView_Previews6: PreviewProvider {
    static var previews: some View {
        let group = BackendGroup()
        return Group {
            
            ChatView(mode: Shapes(), group: group)
        }
    }
}

