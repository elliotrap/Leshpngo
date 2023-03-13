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


// the api goes here
final class viewModel: ObservableObject {
    init() {
        
        
    }
    
    @Published private var client: OpenAISwift?
    @Published var prompt = "give me a non metaphysical meditation prompt from the instructor Ell for an experienced meditator and break down the meditation"
    @Published var meditation = ""
    @Published var models = [String](){
        didSet {
            meditation = "give me a non metaphysical meditation with this prompt: \(models)"
            
            let splitMeditation = meditation.components(separatedBy: ":")
            
            if splitMeditation.count == 2 {
                meditation = String(splitMeditation[1])
            }
        }
    }

    
    
    @Published var synthesizer = AVSpeechSynthesizer()
    
    

    
    @Published var maxHeight: CGFloat = UIScreen.main.bounds.height / 2.76
    @Published var sliderProgress: CGFloat = 0
    @Published var sliderHeight: CGFloat = 0
    @Published var lastDragValue: CGFloat = 0
    
    // API token
    func setup() {
        client = OpenAISwift(authToken: "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")
        
    }
    
    
    
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 75, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        })
    }
    
    
    func generatePrompt() {
        models = [String]()
        
        send(text: prompt) { response in
            DispatchQueue.main.async {
                self.models.append(response)
                
            }
            
        }
    }
    
    func fetchPrompt() {
        models = [String]()
        
        send(text: meditation) { response in
            DispatchQueue.main.async {
                self.models.append(response)
                
            }
            
        }
    }
    
    func aiVoices(_ script: String, withPause pause: TimeInterval) {
        let segments = script.components(separatedBy: "+")
        let synthesizer = AVSpeechSynthesizer()
        
        var segmentIndex = 0
        
        func speakNextSegment() {
            
            
            guard segmentIndex < segments.count else { return }
            
            let segment = segments[segmentIndex]
            let utterance = AVSpeechUtterance(string: segment)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
            utterance.rate = 0.3
            synthesizer.speak(utterance)
            
            segmentIndex += 1
        
        }
        
        speakNextSegment()
        
        Timer.scheduledTimer(withTimeInterval: pause, repeats: true) { timer in
            guard !synthesizer.isSpeaking else { return }
            
            speakNextSegment()
            
            if segmentIndex == segments.count {
                timer.invalidate()
        }
    }
}

    


    
}
