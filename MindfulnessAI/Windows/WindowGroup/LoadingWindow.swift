//
//  LoadingWindow.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 12/4/23.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @ObservedObject var shapeVm = Shapes.shared

    var body: some View {

 
        
        
        
        ZStack {
            
            
            VStack(spacing: 0) {
                Image(systemName: "rainbow")
                    .shadow(color: Color("homeBrewSelect"),radius: 10, x: 0, y: 0)
                    .font(.system(size: 70.8))
                    .foregroundColor(Color("homeBrewSelect"))
                    .symbolEffect(
                        .variableColor
                            .iterative
                            .reversing
                        
                    )
                Text("L  E S H P I N G O")
                    .font(.system(size: 13))
                    .foregroundColor(Color("homeBrewSelect"))
                    .shadow(color: Color("homeBrewSelect"),radius: 10, x: 0, y: 5)
               
            }
         
        }
        .frame(minWidth: 100, maxWidth: 700, minHeight: 0, maxHeight: 800)
                        .background(LinearGradient (
                            gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
                            startPoint: .bottom,
                            endPoint: .top))
                        .environmentObject(shapeVm)
                        .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)

         

        




    }
    
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
