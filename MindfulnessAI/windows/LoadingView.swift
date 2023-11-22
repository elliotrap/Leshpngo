//
//  LoadingView.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 11/15/23.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @State private var isAnimating: Bool = false
    @ObservedObject var shapeVm = Shapes.shared

    var body: some View {
        VStack {
            ZStack {
                
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.clear)
                    .frame(width: 220, height: 70)
                    .modifier(Shapes.NeumorphicCircle())

                
                Text("Léshpngo")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .foregroundColor( Color("homeBrewSelect"))
            }
            Spacer()
                .frame(height: 50)
            ZStack {
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 120, height: 120)
                    .modifier(Shapes.NeumorphicCircle())

                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color("homeBrewSelect"), lineWidth: 1.5)
                    .frame(width: 100, height: 100)
                    .modifier(Shapes.SpinningModifier())

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient (
            
            gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
            startPoint: .bottom,
            endPoint: .top))
        .environmentObject(shapeVm)
        .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)
    }
}
struct ContentView_Previews4: PreviewProvider {
    static var previews: some View {
        return Group {
            
            LoadingView()
        }
    }
}
