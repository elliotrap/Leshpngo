//
//  MAIcolors.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/16/23.
//

import Foundation
import SwiftUI

class ColorViewModel: ObservableObject {
    
    
    @Published var colorHex1: Double = 0.00
    @Published var colorHex2: Double = 0.00
    @Published var colorHex3: Double = 0.00
    @Published var color: Color
    init(){
        color = Color(red: 0.0, green: 0.0, blue: 0.0)
    }
    @Published var blue = Color(red: 21 / 255, green: 6 / 255, blue: 75 / 255)
    @Published var homeBrew = Color(red: 107 / 255, green: 214 / 255, blue: 110 / 255)
    @Published var offBlack = Color(red: 20 / 255, green: 20 / 255, blue: 28 / 255)
   @Published var shadowBlack = Color(red: 13 / 255, green: 13 / 255, blue: 20 / 255)
    @Published var offBlue = Color(red: 28 / 255, green: 28 / 255, blue: 38 / 255)
    @Published var blackScreen = Color(red: 12 / 255, green: 12 / 255, blue: 18 / 255)
    @Published var deepGray = Color(red: 39 / 255, green: 45 / 255, blue: 39 / 255)

    func colorSetup() {
        color = Color(red: colorHex1 / 255, green: colorHex2 / 255, blue: colorHex2 / 255)
    }
    
//    func run() {
//       
//        DispatchQueue.global(qos: .background).async {
//            while true {
//                self.colorHex1 += 5
//                if self.colorHex1 >= 125 {
//                    self.colorHex1 -= 5
//                    self.colorHex2 += 5
//                    if self.colorHex2 >= 125{
//                        self.colorHex2 -= 5
//                        self.colorHex3 += 5
//                        if self.colorHex3 >= 125 {
//                            self.colorHex3 += 5
//                            self.colorHex3 -= 5
//                        }
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.colorSetup()
//                }
//                Thread.sleep(forTimeInterval: 0.1)
//                
//            }
//        }
//        }

}

let contentView1 = ColorViewModel()
