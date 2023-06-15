//
//  ContentView.swift
//  PumpThatShiz0.1
//
//  Created by Elliot Rapp on 6/5/23.
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
        VStack(spacing: 0) {
            ZStack {
                
               
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
          
                    
                    VStack(spacing: 100) {
                        
                        
                        
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
                    Text("Pump")
                        .font(.system(size: 20))
                        .font(.title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .frame(width: 14, height:100)
                        .foregroundColor(Color.white)
         
                }
                
     
    
            }
            HStack {
                Text("volume:")
                    .multilineTextAlignment(.center)
                    .frame(width: 60, height: 100)
                    .foregroundColor(Color.black)
                Text (
                    String(format: "%.0f", sliderProgress)
                )
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
