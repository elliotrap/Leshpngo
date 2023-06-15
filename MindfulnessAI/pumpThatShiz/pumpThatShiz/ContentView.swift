//
//  ContentView.swift
//  pumpThatShiz
//
//  Created by Elliot Rapp on 5/31/23.
//
import SwiftUI

struct ContentView: View {
   
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    @State var pumpPlusFive: CGFloat = 100
    @State var speakerWave = 0
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    var body: some View {
        
        ZStack {
           
            VStack(spacing: 0) {
             
            
                    Rectangle()
                        .foregroundColor(Color.blue)
                        .frame(height: 900)
          
                    
                
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "house.fill")
                            .foregroundColor(Color.brown)
                            .font(.system(size: 150))
                    }
                    
                   
                    ZStack(alignment: .bottom, content: {
                      
                        
                     
                            VStack(spacing: 0) {
                                HStack(spacing: 0){
                                    
                                    Rectangle()
                                        .frame(width:30, height:7)
                                    
                                    RoundedRectangle(cornerRadius: 0)                            .foregroundColor(Color.red)
                                        .frame(width: 20, height: 5)
                                    Rectangle()
                                        .frame(width:30, height:7)
                                }
                                
                                Rectangle()
                                
                                    .foregroundColor(Color.clear)
                                    .frame(width: 9, height: sliderHeight)
                                    .background(Color.gray)
                                
                            }
              
                        
                        VStack(spacing: 0) {
                            
                            
                            
                        }
                        .frame(height: maxHeight)
                        
                    })
                    
                    // the logic for the slider
                    .gesture(DragGesture(minimumDistance:
                                            0).onChanged({ (value) in
                        
                        let translation = value.translation
                        
                        
                        sliderHeight = translation.height - lastDragValue
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        sliderProgress += 0.1
                        pumpPlusFive += 0.3
        
                    }) .onEnded({ (value) in
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        
                        lastDragValue = sliderHeight
                        
                    }))
                }
                HStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 3, height: 10)
                        .foregroundColor(Color.clear)
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 40, height: 180)
                        Text("volume")
                            .multilineTextAlignment(.center)
                            .lineLimit(12)
                            .frame(width: 11, height: 180)
                            .foregroundColor(Color.white)
                    }
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 3, height: 15)
        
                }
                Ellipse()
                    .trim(from: 0.62, to: 0.98)
                    .stroke(lineWidth: 2)
                    .rotationEffect(.degrees(60))
                    .frame(width: 175, height: 420)
                    .foregroundColor(Color.black)
                    .position(x: 115, y: 37)
                ZStack {
                    VStack {
                        HStack {
                            
                            ZStack {
                            
                                Circle()
                                    .foregroundColor(Color.white)
                                    
                            Image(systemName: "soccerball")
                                    .font(.system(size: pumpPlusFive))

                            Text (
                                String(format: "%.0f", sliderProgress)
                                
                            )
                            .font(.system(size: 40))
                            .padding(.trailing, 40)
                            .foregroundColor(Color.white)
                            .padding(.leading, 38)
                        }
                        }
                        
                        Spacer(minLength: 750)
                    }
                    
                    
                }
                
                
            }
            
        }
        .background(LinearGradient (
            
            gradient: Gradient(colors: [Color.green, Color.green]),
            startPoint: .top,
            endPoint: .bottom)
                    )
    }
  
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
