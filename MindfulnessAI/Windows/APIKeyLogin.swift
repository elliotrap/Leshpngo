//
//  APIKeyLogin.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 1/2/24.
//
//
//
//
//import SwiftUI
//import RealmSwift
//import Foundation
//import Combine
//
//
//struct APIKeyLogin: View {
//    
//    @ObservedObject var vm = ViewModel()
//    @ObservedObject var mode: Shapes
//    @ObservedObject var shapeVm = Shapes()
//    @ObservedObject var realm = LoginLogout()
//    
//    @State private var apiKey: String = ConstantsUserAPIKey.openAIApiKey
//
//    
//    @State var haveAnAccount = false
//    
//    @State var wrongPassword = false
//    
//    @State var wrongEmail = false
//    
//    @State var showXIcon = false
//    @State var showXIconTwo = false
//    
//    @State var showXIconThree = false
//    
//    @State var group = BackendGroup()
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // background
//                Rectangle()
//                    .fill(LinearGradient (
//                        
//                        gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
//                        startPoint: .bottom,
//                        endPoint: .top))
//                    .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)
//                
//                    .frame(minWidth: 900, maxWidth: 1000, minHeight: 700, maxHeight: 2500)
//                    .edgesIgnoringSafeArea(.all)
//                
//                
//                VStack{
//                    ZStack {
//                        VStack {
//                            Rectangle()
//                                .foregroundColor(.clear)
//                                .frame(width: 200)
//                                .modifier(Shapes.FlickeringBinaryBackground())
//                        }
//                        
//                        
//                    }
//                    .padding(10)
//                    .scaleEffect(1)
//                    Spacer()
//                        .frame(height: 650)
//                }
//                
//                VStack {
//                    Spacer()
//                        .frame(height: 110)
//                    ZStack(alignment: .top) {
//                        
//                        RoundedRectangle(cornerRadius: 30)
//                            .foregroundColor(Color("offBlack"))
//                            .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
//                            .frame(width: 350, height: 490)
//                        
//                        VStack {
//                            Spacer()
//                                .frame(height: 40)
//                            Text("").padding()
//                                .underline(false)
//                                .buttonStyle(.borderless)
//                                .frame(width: 150, height: 50)
//                                .cornerRadius(40)
//                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
//                                .overlay(
//                                    Text("API keys")
//                                        .fontWeight(.thin)
//                                        .font(.system(size: 22))
//                                        .foregroundColor(Color("homeBrew"))
//                                    
//                                )
//                            Spacer()
//                                .frame(height:25)
//                            if haveAnAccount == false {
//                                VStack {
//                                    Text("Enter your ChatGPT API key")
//                                        .fontWeight(.thin)
//                                        .foregroundColor(Color("homeBrew"))
//                                    
//                                    Spacer()
//                                        .frame(height: 10)
//                                    
//                                    ZStack {
//                                
//                                        
//                                    
//                                            Rectangle()
//                                                .frame(width: 300, height: 50)
//                                                .foregroundColor(.clear)
//                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
//                                              TextField("API Key", text: $apiKey)
//                                                .padding(.leading, 25)
//                                                .padding(.top, 4)
//                                                .foregroundColor(Color("homeBrew"))
//                                                .frame(width: 300, height: 50)
//                                                  .onReceive(Just(apiKey)) { newValue in
//                                                              ConstantsUserAPIKey.openAIApiKey = newValue
//                                                          }
//                                                
//                                        
//                                       
//                                        
//                                        
//                                    }
//                                    Spacer()
//                                        .frame(height: 35)
//                                    Text("Enter your Google Cloud text-to-speech API key")
//                                        .frame(width: 200)
//                                        .fontWeight(.thin)
//                                        .foregroundColor(Color("homeBrew"))
//                                    VStack {
//                                        Spacer()
//                                            .frame(height: 10)
//                                        
//                                        ZStack {
//                                            Rectangle()
//                                                .frame(width: 300, height: 50)
//                                                .foregroundColor(.clear)
//                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
//                                            
//                                            SecureField( "Google Cloud tts API key", text: $realm.password)
//                                                .padding(.leading, 25)
//                                                .padding(.top, 4)
//                                                .foregroundColor(Color("homeBrew"))
//                                                .frame(width: 300, height: 50)
//                                                .onTapGesture {
//                                                    showXIcon = true
//                                                }
//                                            if showXIcon {
//                                                HStack {
//                                                    Spacer()
//                                                        .frame(width: 240)
//                                                    Image(systemName: "x.circle.fill")
//                                                        .foregroundColor(.red)
//                                                        .onTapGesture {
//                                                            realm.password = ""
//                                                            showXIcon = false
//                                                        }
//                                                    
//                                                }
//                                            }                                        }
//                                        
//                                        Spacer()
//                                            .frame(height: 5)
//                                 
//                                        
//                                        Spacer()
//                                            .frame(height: 10)
//                                        ZStack {
//                                         
//                                            
//                             
//                                            
//                                        }
//                                        Spacer()
//                                            .frame(height: 30)
//                                        ZStack {
//                                            VStack(spacing: 25) {
//                                                NavigationLink(destination: ChatView(mode: Shapes(), vm: vm, group: group), label: {
//                                                    HStack {
//                                                        
//                                                        Text("Enter API key")
//                                                            .fontWeight(.thin)
//                                                            .frame(width: 110)
//                                                            .underline(false)
//                                                        
//                                                        Image(systemName: "key")
//                                                    }
//                                                })
//                                                .buttonStyle(.borderless)
//                                                .foregroundColor(Color("homeBrew"))
//                                                .frame(width: 200, height: 70)
//                                                .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
//                                                .zIndex(1)
//                                                
//                            
//                                                
//                                                
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .background(LinearGradient (
//
//            gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
//            startPoint: .bottom,
//            endPoint: .top))
//        .environmentObject(shapeVm)
//        .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)
//    }
//}
//    
//struct ContentView_Previews9: PreviewProvider {
//    static var previews: some View {
//        APIKeyLogin(mode: Shapes())
//    }
//}
