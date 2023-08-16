//
//  DatabaseLogin.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 6/27/23.
//

import Foundation
import Foundation
import SwiftUI


struct DatabaseLoginView: View {
    
    @ObservedObject var vm = ViewModel()
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes()
    @StateObject var realm = LoginLogout()
    
    @State var haveAnAccount = false
    

    
    var body: some View {
        NavigationView {
            ZStack {
                // background
                Rectangle()
                    .fill(LinearGradient (
                        
                        gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
                        startPoint: .bottom,
                        endPoint: .top))
                    .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)

                    .frame(minWidth: 900, maxWidth: 1000, minHeight: 700, maxHeight: 2500)
                    .edgesIgnoringSafeArea(.all)

                
                VStack{
                    ZStack {
                        // leshpngo background for the logo
                        Text(vm.onesAndZeros[vm.onesAndZerosIndex])
                            .frame(width: 310, height: 80)
                            .cornerRadius(100)
                        //.font(.system(size:14.3))
                            .font(.system(size:13.35))
                            .lineLimit(nil)
                            .shadow(color: Color.white, radius: 10,  y: 10)
                            .foregroundColor(Color("homeBrew"))
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
                            .zIndex(0)
                        // name of the app
                        
                        Text("Léshpngo")
                            .font(.system(size: 50))
                            .font(.caption)
                            .foregroundColor(Color("offBlue"))
                            .zIndex(5)
                        
                    }
                    
                    .padding(10)
                    .scaleEffect(1)
                    Spacer()
                        .frame(height: 650)
                }
                
                
                
                VStack {
                    Spacer()
                        .frame(height: 110)
                    ZStack(alignment: .top) {
                        
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("offBlack"))
                            .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                            .frame(width: 350, height: haveAnAccount ? 500 : 590)
                        
                        VStack {
                            Text("Welcome")
                                .foregroundColor(Color("homeBrew"))
                                .frame(width: 150, height: 70)
                                .modifier(Shapes.NeumorphicBox())
                            Spacer()
                                .frame(height: 15)
                            if haveAnAccount == false {
                                VStack {
                                    Text("Enter your name")
                                        .foregroundColor(Color("homeBrew"))
                                    
                                    Spacer()
                                        .frame(height: 0)
                                    
                                    TextField( "name:", text: $realm.email)
                                        .padding(.leading, 40)
                                        .padding(.top, 4)
                                        .foregroundColor(Color("homeBrew"))
                                        .frame(width: 300, height: 70)
                                        .modifier(Shapes.NeumorphicBox())
                                    
                                    Spacer()
                                        .frame(height: 10)
                                    Text("Enter a passwoard")
                                        .foregroundColor(Color("homeBrew"))
                                    VStack {
                                        Spacer()
                                            .frame(height: 0)
                                        TextField("password:", text: $realm.password)
                                            .padding(.leading, 40)
                                            .padding(.top, 4)


                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 300, height: 70)
                                            .modifier(Shapes.NeumorphicBox())
                                        Spacer()
                                            .frame(height: 10)
                                        Text("reenter a passwoard")                            .foregroundColor(Color("homeBrew"))
                                        Spacer()
                                            .frame(height: 0)
                                        TextField("password:", text: $realm.password)
                                            .padding(.leading, 40)
                                            .padding(.top, 4)

                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 300, height: 70)
                                            .modifier(Shapes.NeumorphicBox())
                                        Spacer()
                                            .frame(height: 15)
                                        
                                        Button(action: {
                                            realm.signup()
                                        }, label: { Text("Create account")
                                                .frame(width: 100)
                                                .underline(false)
                                        })
                                        .buttonStyle(.borderless)
                                        .foregroundColor(Color("homeBrew"))
                                        .frame(width: 125, height: 70)
                                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                        
                                        Spacer()
                                            .frame(height: 20)
                                        Button(action: {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                                                haveAnAccount = true
                                            }
                                        }, label:{
                                            Text("already have an account?")
                                                .frame(width: 100)
                                                .underline(false)

                                        })
                                        .buttonStyle(.borderless)
                                        .foregroundColor(Color("homeBrew"))
                                        .frame(width: 200, height: 70)
                                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                    }
                                }
                            } else if haveAnAccount == true {
                                VStack {
                                    Text("Enter your username")
                                        .foregroundColor(Color("homeBrew"))
                                    
                                    Spacer()
                                        .frame(height: 0)
                                    
                                    TextField("name:", text: $realm.email)
                                        .padding(.leading, 40)
                                        .padding(.top, 4)
                                        .foregroundColor(Color("homeBrew"))
                                        .frame(width: 300, height: 70)
                                        .modifier(Shapes.NeumorphicBox())
                                    Spacer()
                                        .frame(height: 10)
                                    Text("Enter your password")
                                        .foregroundColor(Color("homeBrew"))
                                    VStack {
                                        Spacer()
                                            .frame(height: 0)
                                        TextField("password:", text: $realm.password)
                                            .padding(.leading, 40)
                                            .padding(.top, 4)
                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 300, height: 70)
                                            .modifier(Shapes.NeumorphicBox())
                                        
                                        Spacer()
                                            .frame(height: 30)
                                        Button(action: {

                                            realm.login()
                                            
                                        }, label: { Text("Login")
                                                .underline(false)

                                        })
                                        .buttonStyle(.borderless)
                                        .foregroundColor(Color("homeBrew"))
                                        .frame(width: 100, height: 70)
                                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                        Spacer()
                                            .frame(height: 20)
                                        Button(action: {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                                                haveAnAccount = false
                                            }
                                        }, label:{
                                            Text("don't have an account?")
                                                .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                                .foregroundColor(Color("homeBrew"))
                                                .frame(width: 125)
                                                .underline(false)

                                        })
                                        .buttonStyle(.borderless)
                                        .frame(width: 200, height: 70)
                                        .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        DatabaseLoginView(mode: Shapes())
    }
}
