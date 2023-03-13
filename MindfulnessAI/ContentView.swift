//
//  ContentView.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/16/23.
//
import Foundation
import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @ObservedObject var vm = viewModel()
    
    @ObservedObject var cvm = ColorViewModel()
    
    @StateObject var myObject = ColorViewModel()

    var body: some View {
        
        NavigationView {
            ScrollView {
                ZStack {

                    
                    
                    RoundedRectangle(cornerRadius: 30)
                        .stroke()
                        .frame(width: 355, height: 460)
                        .foregroundColor(cvm.homeBrew)
                    
                    
                    ZStack(alignment: .leading) {
                        
                        ForEach(vm.models, id: \.self) { string in
                            Text(string)
                            
                        }
                        ForEach(vm.models, id: \.self) { string in
                            Text(string)
                            
                        }
                
                    }
                    

                    
                        .foregroundColor(cvm.homeBrew)
                        .frame(width: 290, height: 350)
                        .position(x: 300, y: 200)
                        .zIndex(5)
                        
                    RoundedRectangle(cornerRadius: 50)
                        .fill(cvm.offBlack)
                        .frame(width: 350, height: 450)
                        .modifier(neumorphicBox())
                        .zIndex(3)
                    
           
                    
                
      
                
                    
            
                    
                }
                .onAppear {
                    vm.setup()
                }

                
                HStack {
                    
                    HStack( content:  {
     
                            // button for bar graph
                            Button(action:  {
                              
                                
                            })
                            {
                                
                                Text("Sum").padding()
                                    .underline(false)
                                Image(systemName: "alien.black.icons")
                                    .background(Color.black)
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(cvm.homeBrew)
                            
                            // button for point graph
                            Button(action: {
                           
                                
                                
                                
                            }) {
                                Text("Int").padding()
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(cvm.homeBrew)
                            
                            // button for line graph
                            Button(action: {
                            
                                
                                
                                
                                
                            }) {
                                Text("Ell").padding()
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(cvm.homeBrew)
                            
                            Button(action: {
                              
                                
                                
                                
                                
                            }) {
                                Text("Zil").padding()
                                    .underline(false)
                                
                            }
                            .buttonStyle(.borderless)
                            .foregroundColor(cvm.homeBrew)
                        
                        
                    })
                    
                    
                    .frame(width: 330, height: 100)
                    
               
                    .cornerRadius(20)
                    .modifier(neumorphicBox())
                    .position(x:300, y: 230)
                    .zIndex(4)
                    
                    
                    // generate meditation
                    Button(action: {
                        vm.generatePrompt()
                        
                    } ,
                           label: {
                        
                        
                        Image(systemName: "arrow.2.squarepath").resizable().frame(width: 90, height: 80) // reset button
                            .foregroundColor(cvm.homeBrew)
                        
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    .background(ZStack {
                        cvm.shadowBlack
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(cvm.offBlue)
                            .blur(radius: 10)
                            .offset(x: -8, y: -8)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [cvm.offBlue, cvm.offBlack]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    })
                    .cornerRadius(10)
                    .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                    .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
                    .position(x: 190, y: 90)
                    .zIndex(4)

                    
                    NavigationLink(destination: MainMeditation(), label: {
                        Image(systemName: "play.circle").resizable().frame(width:60, height: 60) // play button

                            .foregroundColor(cvm.homeBrew)
                            
                            .onTapGesture {
                                vm.aiVoices(vm.meditation, withPause: 10)
                                vm.fetchPrompt()
                            }
                        
                    })
                 
                    .buttonStyle(.borderless)
                    .frame(width: 150, height: 150)
                    .background(ZStack {
                        cvm.shadowBlack
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundColor(cvm.offBlue)
                            .blur(radius: 10)
                            .offset(x: -8, y: -8)
                        RoundedRectangle(cornerRadius: 100)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [cvm.offBlue, cvm.offBlack]), startPoint: .bottomTrailing, endPoint: .topLeading)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    })
                    .cornerRadius(100)
                    .shadow(color: cvm.shadowBlack, radius: 20, x: 20, y: 20)
                    .shadow(color: cvm.offBlue, radius: 20, x: -20, y: -20)
                    .position(x:-200, y: 90)
                    .zIndex(4)

                    
                    
   
                    
                }

                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke()
                        .frame(width: 330, height: 100)
                        .foregroundColor(cvm.homeBrew)
                        .position(x:300, y: 75)
                }
                
                HStack {
                    
                    Text("DAYS")
                        .font(.system(size: 13))
                        .foregroundColor(cvm.homeBrew)
                        .position(x: 160, y: 700)
                    
                    
                    Text("HOURS")
                        .font(.system(size: 13))
                        .foregroundColor(cvm.homeBrew)
                        .position(x: 100, y: 700)
                    
                    Text("SESSIONS")
                        .font(.system(size: 13))
                        .foregroundColor(cvm.homeBrew)
                        .position(x: 30, y: 700)
                }
                .frame(minWidth: 600, maxWidth: 600, minHeight: 0, maxHeight: 0)
            }
            .background(cvm.offBlack)
            
            
        }
    }
}




struct neumorphicBox: ViewModifier {
    
    @ObservedObject var cvm = ColorViewModel()

    @State var radius: CGFloat = 40
    
    func body(content: Content) -> some View {
        content
            .overlay (
            RoundedRectangle(cornerRadius: radius)
                .stroke(cvm.offBlack, lineWidth: 30)
                .shadow(color: cvm.blackScreen, radius: 6, x: 10, y: 10)
                .clipShape(RoundedRectangle(cornerRadius: radius))
                .shadow(color: cvm.offBlue, radius: 6, x: -5, y: -5)
                .clipShape(RoundedRectangle(cornerRadius: radius))


            )
            .zIndex(1)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()

    }
}
