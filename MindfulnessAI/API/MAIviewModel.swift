//
//  MAIviewModel.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 2/16/23.
//

import OpenAISwift
import Foundation
import SwiftUI
import AVFoundation
import RealmSwift
// the api goes here
class ViewModel: ObservableObject {
    init() {
        
        
    }
    
    @ObservedObject var voice = ChatViewModel()
    
    @Published var loginUsernameText: String = ""

  
   
    

    @Published var tenMinuetButton = true
    @Published var twentyMinuetButton = false
    @Published var thirtyMinuetButton = false

    @Published var minutes = 0
    
    @Published private var client: OpenAISwift?
    @Published var prompt =
    """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
    

    @Published var meditation = ""
    @Published var models = [String]()
    
    @Published var isLoading: Bool = false
    

    @Published var promptIndex = 0

    
    @Published var onesAndZerosIndex = 0


    
    
    @Published var synthesizer = AVSpeechSynthesizer()
    
    @Published var maxHeight: CGFloat = UIScreen.main.bounds.height / 3.30
    @Published var sliderProgress: CGFloat = 0
    @Published var sliderHeight: CGFloat = 0
    @Published var lastDragValue: CGFloat = 0
    
 
    
    @Published var minuteMaxHeight: CGFloat = UIScreen.main.bounds.height / 4.45
    @Published var minuteSliderProgress: CGFloat = 1
    @Published var minuteSliderHeight: CGFloat = 0
    @Published var minuteLastDragValue: CGFloat = 0
    // API key
//    func setup() {
//        client = OpenAISwift(authToken: "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")
//        
//    }
//    // pariameters for the API call
//        func send(text: String, completion: @escaping (String) -> Void) {
//            client?.sendCompletion(with: text, maxTokens: 200, completionHandler: { result in // parameters
//                switch result {
//                case .success(let model):
//                    let output = model.choices.first?.text ?? ""
//                    completion(output)
//                case .failure:
//                    break
//                }
//            })
//        }
//        
//        
//    func generatePrompt() {
//        models = [String]()
//        isLoading = true
//        
//        send(text: prompt) { response in
//            DispatchQueue.main.async {
//                self.models.append(response)
//                self.isLoading = false
//            }
//            
//        }
//    }
//        
//        func fetchPrompt() {
//            models = [String]()
//            
//            send(text: meditation) { response in
//                DispatchQueue.main.async {
//                    self.models.append(response)
//                    
//                }
//                
//            }
//        }
//        
//
//    
//    func aiVoices(_ script: String, withPause pause: TimeInterval) {
//            let segments = script.components(separatedBy: "...")
//            let synthesizer = AVSpeechSynthesizer()
//            
//            var segmentIndex = 0
//            
//            func speakNextSegment() {
//                
//                
//                
//                guard segmentIndex < segments.count else { return }
//                
//                let segment = segments[segmentIndex]
//                let utterance = AVSpeechUtterance(string: segment)
//                utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
//                utterance.rate = 0.3
//                synthesizer.speak(utterance)
//                
//                segmentIndex += 1
//                
//            }
//            
//            speakNextSegment()
//            
//            Timer.scheduledTimer(withTimeInterval: pause, repeats: true) { timer in
//                guard !synthesizer.isSpeaking else { return }
//                
//                speakNextSegment()
//                
//                if segmentIndex == segments.count {
//                    timer.invalidate()
//                }
//            }
//        }
//    



    }
