//
//  ChatVeiwBottom.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 11/15/23.
//

import SwiftUI
import RealmSwift
import Foundation

struct ChatViewBottom: View {
    
    @ObservedObject var mode: Shapes
    @ObservedObject var vm = ViewModel()
    @ObservedObject var shapeVm = Shapes.shared
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    
    @ObservedRealmObject var group: BackendGroup
    let savedItems = Item.self

    
    @State var playing = true
    @State var pressedReset = true
    @State var startLessonPrompt = true
    @State var startMeditationPrompt = false
    

    
 
    
  
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 350, height: 450)
                .foregroundColor(Color("offBlack"))
                .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
            if viewModel.GPTLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("homeBrew")))
                        .scaleEffect(2)
                        .zIndex(6)
                    
                    Spacer()
                        .frame(height: 170)
                }
            }
            // MARK: - Lesson section
            VStack {
                Spacer()
                    .frame(height: 10)
                ZStack {
                    HStack(content:  {
                        
                        
                        Text("")
                        
                    })
                    .frame(width: 130, height: 50)
                    .cornerRadius(40)
                    .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                    .overlay(
                        // the label for describing the lesions section
                        Text("lessons").padding()
                            .fontWeight(.thin)
                            .font(.system(size: 22))
                            .underline(false)
                            .buttonStyle(.borderless)
                            .foregroundColor(Color("homeBrew"))
                        
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
                    .foregroundColor(Color("homeBrewSelect"))
                    .scaleEffect(0.9)
                    .zIndex(2)
                // the box that holds the text for the lesion
                // MARK: - Text box
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.clear)
                    .frame(width: 300, height: 340)
                    .modifier(Shapes.NeumorphicClickedBox())
                ZStack {
                    VStack {
                        VStack {
                            if startLessonPrompt {
                                VStack {
                                    Image(systemName: "arrow.2.squarepath")
                                        .fontWeight(.thin)
                                    
                                    //    .position(x: 61, y: 67)
                                        .position(x: 60, y: 68)
                                        .foregroundColor(Color("homeBrew"))
                                    
                                    HStack {
                                        
                                        Text("Generate a lesson by pressing the        button.")
                                            .fontWeight(.thin)
                                            .font(.system(size: 20))
                                            .frame(width: 280, height: 60)
                                        
                                    }
                                }
                                Spacer()
                                    .frame(height: 200)
                            }
                            
                            ScrollView {

                                
                                
                                // The text that is generated for the lesions
                                
                                if let firstMessage = viewModel.messages.last(where: { $0.role != .system }) {
                                    
                                    Text(firstMessage.content)
                                        .padding(.top, 30)
                                        .padding(.bottom, 30)
                                }
                                
                                
                            }
                            
                        }
                        
                        
                        .foregroundColor(Color("homeBrew"))
                        .frame(width: 290, height: 370)
                        .zIndex(5)
                        Spacer()
                            .frame(height: 35)
                    }
                    if viewModel.GPTLoading {
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(tint: Color("homeBrew"))
                            )
                            .scaleEffect(2)
                            .zIndex(5)
                    }
                    
                 
                }
                .scaleEffect(0.9)

            }

        }
        .scaleEffect(0.9)

            // MARK: - Back 15 seconds

            HStack {
                Button(action: {
                    viewModel.rewind15Seconds()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.backward.2" )
                            .fontWeight(.thin)
                            .foregroundColor(Color("homeBrew"))

                        Text("15")
                            .underline(false)
                            .foregroundColor(Color("homeBrew"))


                    }

                })
                    .buttonStyle(.borderless)
                    .frame(width: 100, height: 50)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCircle(mode: mode))
                    .zIndex(4)
            
                Spacer()
                    .frame(width: 75)
        
                    Button(action: {
                        viewModel.forward15Seconds()
                    }, label: {
                        HStack {
                            Text("15")
                                .underline(false)
                                .foregroundColor(Color("homeBrew"))

                            Image(systemName: "chevron.forward.2" )
                                .fontWeight(.thin)
                                .foregroundColor(Color("homeBrew"))
                          
                        }
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 100, height: 50)
                    // nuemorphic design
                    .modifier(Shapes.NeumorphicCircle(mode: mode))
                    .zIndex(4)
                    
              
                    
                
            }

            VStack {
                Spacer(minLength: 20)
                HStack(spacing: 40) {
                    
                    if playing {
                        
                        // MARK: - lession play button
                        Button(action: {
                            playing.toggle()
                            viewModel.togglePauseResume()
                            viewModel.startMeditation()
                            if viewModel.ttsIsTalking == true {
                                viewModel.textToSpeech(ssmlText: viewModel.latestAssistantMessage)
                            }
                        }, label: {
                            Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button
                                .fontWeight(.thin)
                                .foregroundColor(Color("homeBrew"))
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 150, height: 150)
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCircle(mode: mode))
                        .zIndex(4)
                    } else {
                        // lession play button
                        Button(action: {
                            playing.toggle()
                            viewModel.togglePauseResume()
                            viewModel.ttsIsTalking = false
                            viewModel.stopMeditation()

                          
                        }, label: {
                            Image(systemName:  "pause.circle").resizable().frame(width: 55, height: 55) // play button
                                .fontWeight(.thin)

                                .foregroundColor(Color.red)
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 150, height: 150)
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicCirclePushedIn(mode: mode))
                        .zIndex(4)
                    }
                    if pressedReset {
                        // MARK: - generate meditation button
                        Button(action: {
                            DispatchQueue.main.async {
                                playing = true
                                viewModel.justPause()
                                viewModel.sendMessage(messageContent:
                                                  """
                                                   You are a well trained meditation instructor training people through an app, please provide lessons about meditation and mindfulness without walking through a meditation. Please don't add a title or heading to the lessons. Make the lessons very punctuate using a lot of "...", and commas.
                                                  """, systemContent:
                                                  """
                                                  Please give me a high level lesson on meditation without walking through a meditation. Use a lot of '...' in the speech of the lesson also please use a lot of commas. Please don't give a Title for the meditation. Thank you.
                                                  """)
                                startLessonPrompt = false
                                startMeditationPrompt = false
                                pressedReset = false
                                viewModel.isPaused = true
                                viewModel.ttsIsTalking = true
                                viewModel.stopMeditation()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                pressedReset = true
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
                        Button(action: {},
                               label: {
                            
                            Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                                .fontWeight(.thin)

                                .foregroundColor(Color("homeBrew"))
                        })
                        .cornerRadius(30)
                        .buttonStyle(.borderless)
                        .frame(width: 150, height: 150)
                        // nuemorphic design
                        .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                        .overlay(
                            Image(systemName: "arrow.2.squarepath").resizable().frame(width: 80, height: 70) // reset button
                                .fontWeight(.thin)
                                .foregroundColor(Color("grayBlack"))
                        )
                    }
                }
            }
            .scaleEffect(0.9)
    }
}

struct ContentView_Previews7: PreviewProvider {
    static var previews: some View {
        let group = BackendGroup()
        return Group {
            
            ChatView(mode: Shapes(), group: group)
        }
    }
}

