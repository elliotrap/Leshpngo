//
//  DatabaseLogin.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 6/27/23.
//

import SwiftUI
import RealmSwift
import Foundation


struct DatabaseLoginView: View {
    
    @ObservedObject var vm = ViewModel()
    @ObservedObject var mode: Shapes
    @ObservedObject var shapeVm = Shapes()
    @ObservedObject var realm = LoginLogout()
    
    @State var haveAnAccount = false
    
    @State var wrongPassword = false
    
    @State var wrongEmail = false
    
    @State var showXIcon = false
    @State var showXIconTwo = false
    
    @State var showXIconThree = false
    
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
                        VStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 200)
                                .modifier(Shapes.FlickeringBinaryBackground())
                        }
                    
                        
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
                            Spacer()
                                .frame(height: 20)
                            Text("").padding()
                                .underline(false)
                                .buttonStyle(.borderless)
                                .frame(width: 150, height: 50)
                                .cornerRadius(40)
                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                .overlay(
                                    Text(haveAnAccount ? "Log In" : "Sign Up")
                                    .fontWeight(.thin)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color("homeBrew"))

                                )
                            Spacer()
                                .frame(height: 15)
                            if haveAnAccount == false {
                                VStack {
                                    Text("Enter your Email")
                                        .fontWeight(.thin)
                                        .foregroundColor(Color("homeBrew"))
                                    
                                    Spacer()
                                        .frame(height: 10)
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 300, height: 50)
                                            .foregroundColor(.clear)
                                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                        
                                        TextField( "Email", text: $realm.email)
                                            .padding(.leading, 25)
                                            .padding(.top, 4)
                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 300, height: 50)
                                        
                                        
                                    }
                                    Spacer()
                                        .frame(height: 15)
                                    Text("Enter a password")
                                        .fontWeight(.thin)
                                        .foregroundColor(Color("homeBrew"))
                                    VStack {
                                        Spacer()
                                            .frame(height: 10)
                                        
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 300, height: 50)
                                                .foregroundColor(.clear)
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                           
                                                SecureField( "password", text: $realm.password)
                                                    .padding(.leading, 25)
                                                    .padding(.top, 4)
                                                    .foregroundColor(Color("homeBrew"))
                                                    .frame(width: 300, height: 50)
                                                    .onTapGesture {
                                                        showXIcon = true
                                                    }
                                            if showXIcon {
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 240)
                                                    Image(systemName: "x.circle.fill")
                                                        .foregroundColor(.red)
                                                        .onTapGesture {
                                                            realm.password = ""
                                                            showXIcon = false
                                                        }
                                                    
                                                }
                                            }                                        }
                                        
                                        Spacer()
                                            .frame(height: 15)
                                        Text("Reenter a password")
                                            .fontWeight(.thin)
                                            .foregroundColor(Color("homeBrew"))
                                        
                                        Spacer()
                                            .frame(height: 10)
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 300, height: 50)
                                                .foregroundColor(.clear)
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                            
                                            SecureField( "password", text: $realm.reenterPassword)
                                                .padding(.leading, 25)
                                                .padding(.top, 4)
                                                .foregroundColor(Color("homeBrew"))
                                                .frame(width: 300, height: 50)
                                                .cornerRadius(30)
                                                .onTapGesture {
                                                    showXIconTwo = true
                                                    
                                                }
                                            if showXIconTwo {
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 240)
                                                    Image(systemName: "x.circle.fill")
                                                        .foregroundColor(.red)
                                                        .onTapGesture {
                                                            realm.reenterPassword = ""
                                                            showXIconTwo = false
                                                        }
                                                    
                                                }
                                            }
                                            
                                        }
                                        Spacer()
                                            .frame(height: 30)
                                        ZStack {
                                        VStack(spacing: 25) {
                                            Button(action: {
                                                if realm.password == realm.reenterPassword {
                                                    realm.signup()
                                                    
                                                }
                                                if realm.password != realm.reenterPassword {
                                                    wrongPassword = true
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                        wrongPassword = false
                                                        
                                                    }
                                                    
                                                }
                                                if realm.isEmailValid(realm.email, min: realm.minLength, max: realm.maxLength) {
                                                    print("The email is valid.")
                                                } else {
                                                    realm.signUpSuccess = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.50) {
                                                        realm.signUpSuccess = false
                                                        
                                                    }
                                                    
                                                }
                                            }, label: { Text("Create account!")
                                                    .fontWeight(.thin)
                                                    .frame(width: 150)
                                                    .underline(false)
                                            })
                                            .buttonStyle(.borderless)
                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 200, height: 70)
                                            .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
                                            .zIndex(1)
                                            
                                            Button(action: {
                                                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                                                    haveAnAccount = true
                                                }
                                                realm.password = ""
                                                realm.email = ""
                                                realm.reenterPassword = ""
                                            }, label:{
                                                Text("Have an account?")
                                                    .fontWeight(.thin)
                                                    .frame(width: 150)
                                                    .underline(false)
                                                
                                                
                                            })
                                            .buttonStyle(.borderless)
                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 200, height: 70)
                                            .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
                                            

                                        }
                                    }
                                }
                                }
                            } else if haveAnAccount == true {
                                VStack {
                                    Spacer()
                                        .frame(height: 5)
                                    Text("Enter your Email")
                                        .fontWeight(.thin)
                                        .foregroundColor(Color("homeBrew"))
                                    
                                    Spacer()
                                        .frame(height: 15)
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 300, height: 50)
                                            .foregroundColor(.clear)
                                            .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                        
                                        TextField("name", text: $realm.email)
                                            .padding(.leading, 25)
                                            .padding(.top, 4)
                                            .foregroundColor(Color("homeBrew"))
                                            .frame(width: 300, height: 50)
                                        
                                    }
                                    Spacer()
                                        .frame(height: 15)
                                    Text("Enter your password")
                                        .fontWeight(.thin)
                                        .foregroundColor(Color("homeBrew"))
                                    VStack {
                                        Spacer()
                                            .frame(height: 10)
                                        
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 300, height: 50)
                                                .foregroundColor(.clear)
                                                .modifier(Shapes.NeumorphicClickedBox(mode: mode))
                                            
                                            SecureField("password", text: $realm.password)
                                                .padding(.leading, 25)
                                                .padding(.top, 4)
                                                .foregroundColor(Color("homeBrew"))
                                                .frame(width: 300, height: 50)
                                                .onTapGesture {
                                                    showXIconThree = true
                                                }
                                            if showXIconThree {
                                                HStack {
                                                    Spacer()
                                                        .frame(width: 240)
                                                    Image(systemName: "x.circle.fill")
                                                        .foregroundColor(.red)
                                                        .onTapGesture {
                                                            realm.reenterPassword = ""
                                                            showXIconThree = false
                                                        }
                                                    
                                                }
                                            }
                                        }
                                        
                                        Spacer()
                                            .frame(height: 30)
                                        ZStack {
                                            VStack(spacing: 25) {
                                                NavigationLink(destination: APIKeyLogin(vm: vm, mode: Shapes())) {
                                                    Button(action: {
                                                        
                                                        
                                                    }, label: {
                                                        HStack {
                                                            Spacer()
                                                                .frame(width: 40)
                                                            Text("Sign in")
                                                                .fontWeight(.thin)
                                                                .underline(false)
                                                            Spacer()
                                                                .frame(width: 20)
                                                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                                                .fontWeight(.thin)
                                                            
                                                        }
                                                        
                                                    })
                                     
                                                }
                                                .buttonStyle(.borderless)
                                                .foregroundColor(Color("homeBrew"))
                                                .frame(width: 200, height: 70)
                                                .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
                                                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)

                                                
                                                Button(action: {
                                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                                                        haveAnAccount = false
                                                    }
                                                }, label:{
                                                    Text("Don't have an account?")
                                                        .fontWeight(.thin)
                                                        .foregroundColor(Color("homeBrew"))
                                                        .frame(width: 125)
                                                        .underline(false)
                                                    
                                                })
                                                .buttonStyle(.borderless)
                                                .frame(width: 200, height: 70)
                                                .modifier(Shapes.NeumorphicMenuPopedOutBox(mode: mode))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                if wrongPassword {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 30)
                            .modifier(Shapes.NeumorphicPopedOutBox(mode: mode))
                            .foregroundColor(Color("offBlack"))
                            .frame(width:300, height: 100)
                        Text("The password you entered does not match")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.red))
                            .frame(width: 200, height: 50)
                    }
                }
                
                if !realm.signUpSuccess && !realm.errorMessage.isEmpty {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .modifier(Shapes.NeumorphicPopedOutBox(mode: realm.mode))
                            .foregroundColor(Color("offBlack"))
                            .frame(width:300, height: 100)
                   
                        Text(realm.errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.red))
                            .frame(width: 200, height: 200)
                       
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.50) {
                                    realm.signUpSuccess = true
                                    
                                }
                            }
                    }
                }
                
            }
        }
        .background(LinearGradient (

            gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
            startPoint: .bottom,
            endPoint: .top))
        .environmentObject(shapeVm)
        .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)
    }
}



struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        DatabaseLoginView(mode: Shapes())
    }
}
