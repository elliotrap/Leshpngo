import Foundation
import SwiftUI
import AVFoundation
import RealmSwift


struct MeditationGenerator: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>



    @ObservedObject var vm = ViewModel()
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes.shared
    @ObservedObject var viewModel = ChatViewModel.shared
    @StateObject var realm = LoginLogout()
    @ObservedRealmObject var group: BackendGroup
    @ObservedObject var helper = RealmHelper()

    @State var startMeditationPrompt = true
    let realmConnect = try! Realm()

    @State var playingMain = true
    @State var pressedResetMain = true
    
    var body: some View {

    NavigationView {
        ZStack {
            VStack(spacing: -35) {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                HStack {
                                    Image(systemName: "arrow.backward")
                                        .foregroundColor(Color("homeBrew"))// Customize color
                                }})
                            .buttonStyle(.borderless)
                            .frame(width: 60, height: 40)
                            .modifier(Shapes.NeumorphicBackCircle(mode: mode))
                            .padding(.trailing, 280)
                            
                        }
                    }
                    Spacer()
                        .frame(height: 25)
                }
                .zIndex(10)
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 350, height: 520)
                        .foregroundColor(Color("offBlack"))
                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                    
                    VStack {
                        
                        Text("")
                            .frame(width: 150, height: 60)
                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                            .overlay(
                                Text("Generate")
                                    .fontWeight(.thin)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color("homeBrew"))
                            )
                        
                        
                        
                        ZStack {
                            // the progress bar for while the meditation is loading
                            if viewModel.GPTLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color("homeBrew")))
                                    .scaleEffect(2)
                                    .zIndex(5)
                                
                            }
                            // green text container background
                            RoundedRectangle(cornerRadius: 30)
                                .stroke()
                                .frame(width: 355, height: 400)
                                .foregroundColor(Color("homeBrewSelect"))
                                .zIndex(3)
                                .padding(.bottom, 30)
                            
                            
                            // layout
                            ZStack {
                                
                                
                                VStack {
                                    // this text shows to the user that in order to generate a meditation you need to click the generate button
                                    if startMeditationPrompt {
                                        VStack {
                                            Image(systemName: "arrow.2.squarepath")
                                                .fontWeight(.thin)
                                            
                                            //    .position(x: 61, y: 42)
                                                .position(x: 60, y: 63)
                                                .foregroundColor(Color("homeBrew"))
                                            
                                            HStack {
                                                // the text that gets displayed for the user to generate a meditation
                                                Text("Generate a lesson by pressing the        button.")
                                                    .fontWeight(.thin)
                                                    .font(.system(size: 20))
                                                    .frame(width: 280, height: 60)
                                            }
                                            Spacer()
                                                .frame(height: 100)
                                        }
                                    }
                                    
                                    ScrollView {
                                        
                                        
                                        // This displays to the user the first message in the list of meditations that have been generated
                                        if viewModel.GPTLoading == false {
                                            // The text that is generated for the lesions
                                            if let firstMessage = viewModel.messages.last(where: { $0.role != .system }) {
                                          
                                                
                                                Text(firstMessage.content)
                                                    .padding(.top, 10)
                                                    .padding(.bottom, 10)
                                                
                                            }
                                        }
                                    }
                                    .padding(.top, 30)
                                   
                                }
                                .foregroundColor(Color("homeBrew"))
                                .frame(width: 290, height: 360)
                                .padding(.bottom, 65)
                                .zIndex(5)
                                
                               
                            
                                // the text box for the generated meditations
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color("offBlack"))
                                    .frame(width: 340, height: 385)
                                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                    .padding(.bottom, 30)
                           
                                
                                VStack {
                                    Spacer()
                                        .frame(height: 435)
                                    
                                    Button(action: {
                                        // This allows the user to save up to 6 meditations
                                        if viewModel.counter < 6 {
                                            
                                            viewModel.counter += 1
                                            let newItem = Item(name: viewModel.latestAssistantMessage, isFavorite: false, savedId: viewModel.counter)

                                            // this saves the meditations
                                            try? realmConnect.write {
                                                realmConnect.add(newItem)
                                            }
                                        }
                                    }, label: {
                                        Text("save")
                                            .underline(false)
                                            .fontWeight(.thin)
                                            .foregroundColor(Color("homeBrew"))
                                    })
                                    .frame(width: 100, height: 45)
                                    .background(Color("offBlue"))
                                    .cornerRadius(100)
                                    .buttonStyle(.borderless)


                                }
                                
                            }
                        
                        }
                    }
                    .scaleEffect(0.9)
                    
                }
                .scaleEffect(0.9)
                .zIndex(6)
            
                // the message that gets displayed to the user that they can only save up to 6 meditations
                if viewModel.counter >= 6 {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 340, height: 200)
                }
                    
                    
                ZStack {
                    
                    VStack {
                        // the structure for the back and forward 15 seconds buttons
                        BackAndForwardButtons(mode: Shapes(), group: group)
                            .zIndex(1)
                        // the play and pause button structure
                        PlayAndGenerateButtons(mode: Shapes(), group: group)
                            
        
                    }
                }
                }
            .frame(minWidth: 100, maxWidth: 700, minHeight: 0, maxHeight: 800)

        }
        
        // the background colors for the app
        .background(LinearGradient (
            gradient: Gradient(colors: [Color("backgroundAppColor"), Color("offBlue")]),
            startPoint: .bottom,
            endPoint: .top))
        .environmentObject(shapeVm)
        .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)

        }
    }
}


struct BackAndForwardButtons: View {
    
    @ObservedObject var vm = ViewModel()
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes.shared
    @ObservedObject var viewModel = ChatViewModel.shared
    @StateObject var realm = LoginLogout()
    @ObservedRealmObject var group: BackendGroup
    @ObservedObject var helper = RealmHelper()

    @State var startMeditationPrompt = true
    let realmConnect = try! Realm()

    @State var playingMain = true
    @State var pressedResetMain = true
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Button(action: {
                    viewModel.rewind15Seconds()
                }, label: {
                    HStack(spacing: 0) {
                        Image(systemName: "chevron.backward.2" )
                            .foregroundColor(Color("homeBrew"))
                        
                        Text("15")
                            .underline(false)
                            .foregroundColor(Color("homeBrew"))
                        
                        
                    }
                    
                })
                .zIndex(2)
                .buttonStyle(.borderless)
                .frame(width: 90, height: 50)
                // nuemorphic design
                .modifier(Shapes.backAndForthButton(mode: mode))
                
                Spacer()
                    .frame(width: 75)
                
                Button(action: {
                    viewModel.forward15Seconds()
                }, label: {
                    HStack(spacing: 0) {
                        Text("15")
                            .underline(false)
                            .foregroundColor(Color("homeBrew"))
                        
                        
                        Image(systemName: "chevron.forward.2" )
                            .foregroundColor(Color("homeBrew"))
                        
                    }
                })
                .buttonStyle(.borderless)
                .frame(width: 90, height: 50)
                // nuemorphic design
                .modifier(Shapes.backAndForthButton(mode: mode))
                
                
                
            }
            Spacer()
                .frame(height: 20)
        }
    }
}

struct PlayAndGenerateButtons: View {
    
    @ObservedObject var vm = ViewModel()
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes.shared
    @ObservedObject var viewModel = ChatViewModel.shared
    @StateObject var realm = LoginLogout()
    @ObservedRealmObject var group: BackendGroup
    @ObservedObject var helper = RealmHelper()

    @State var startMeditationPrompt = true
    let realmConnect = try! Realm()

    @State var playingMain = true
    @State var pressedResetMain = true
    
    var body: some View {
        HStack(spacing: 40) {
            // meditation play link
            if playingMain {
                
                // lession play button
                Button(action: {
                    
                    viewModel.textToSpeech(ssmlText: viewModel.latestAssistantMessage)
                    
                    
                    playingMain.toggle()
                }, label: {
                    Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button
                        .fontWeight(.thin)
                        .foregroundColor(Color("homeBrew"))
                })
                .buttonStyle(.borderless)
                .frame(width: 150, height: 150)
                // nuemorphic design
                .modifier(Shapes.NeumorphicCircle(mode: mode))
                
                
            } else {
                // lession play button
                Button(action: {
                    playingMain.toggle()
                }, label: {
                    Image(systemName: "pause.circle").resizable().frame(width: 50, height: 50) // play button
                        .fontWeight(.thin)
                        .foregroundColor(Color.red)
                })
                .buttonStyle(.borderless)
                .frame(width: 150, height: 150)
                // nuemorphic design
                .modifier(Shapes.NeumorphicCirclePushedIn(mode: mode))
                .zIndex(4)
                
            }
            ZStack {
                if pressedResetMain {
                    
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 150, height: 150)
              
                    // generate meditation button
                    Button(action: {
                        
                        viewModel.sendMessage()
                        startMeditationPrompt = false
                        pressedResetMain = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            pressedResetMain = true
                        }
                    },
                           label: {
                        
                        Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                            .fontWeight(.thin)
                            .foregroundColor(Color("homeBrew"))
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                    
                } else {
                    Button(action: {
                        viewModel.sendMessage()
                    } ,
                           label: {
                        
                        
                        
                    })
                    .cornerRadius(30)
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    .overlay(
                        Image(systemName: "arrow.2.squarepath").resizable().frame(width: 80, height: 70) // reset button
                            .fontWeight(.thin)
                            .foregroundColor(Color.gray)
                    )
                }
            }
        }
        .padding(.top, 0)
        
        .scaleEffect(0.9)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let group = BackendGroup() // Create an instance of your Group class
        MeditationGenerator(mode: Shapes(), group: group)
    }
}
