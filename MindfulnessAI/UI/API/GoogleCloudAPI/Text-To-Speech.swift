//
//  Text-To-Speech.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 8/21/23.
//

import Foundation
import AVFoundation

enum VoiceType: String {
    case undefined
    case waveNetFemale = "en-US-Wavenet-F"
    case waveNetMale = "en-US-Wavenet-D"
    case standardFemale = "en-US-Standard-E"
    case standardMale = "en-US-Standard-D"
}



