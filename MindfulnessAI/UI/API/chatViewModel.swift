//
//  chatViewModel.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 6/20/23.
//

import Foundation
import Alamofire
import SwiftUI
import AVFoundation

        class ChatViewModel: ObservableObject {
            
            var player: AVAudioPlayer?

            private var viewModelTwo = OpenAIService()
            
            @Published var GPTLoading = false

            @Published var latestAssistantMessage: String = ""
            
            @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
          , createAt: Date())]
            
            @Published var currentInput: String = "tell me a story about dogs!"
            
            private let openAIService = OpenAIService()
            
            func sendMeditationMessage() {

                var _ = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
                currentInput = ""
                
                GPTLoading = true

                Task {
                    let response = await openAIService.sendMessage(messages: messages)
                    guard let receivedOpenAIMessage = response?.choices.first?.message else {
                        print("had no received message")
                        return
                    }
                    let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
                  
                    await MainActor.run {
                        messages.append(receivedMessage)
                        latestAssistantMessage = receivedOpenAIMessage.content // Update this line
                    }
                     GPTLoading = false
                }
            }
            
                func textToSpeech(ssmlText: String) {
                    let apiKey = "AIzaSyDf2LDCrnMC1fnEaZN5-iNYh8f9EOMjH1I"
                
                    let url = URL(string: "https://texttospeech.googleapis.com/v1/text:synthesize?key=\(apiKey)")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
           
                    let escapedResponseText = ssmlText.replacingOccurrences(of: "...", with: "<break time=\"5s\"/>")
                    let sssmlText = "<speak><prosody volume=\"soft\">This is spoken softly.</prosody></speak>"

                    let ssmlText = "<speak>\(escapedResponseText)</speak>"
                    
                    print("SSML Text: \(ssmlText)")
                    
                    let input: [String: Any] = ["ssml": ssmlText]
                    
                    let voice = ["languageCode": "en-AU", "name": "en-AU-Standard-C"]
                        let audioConfig: [String: Any] = ["audioEncoding": "MP3", "sampleRateHertz": 16000, "speakingRate": 0.7]
                   
                       
                       
                        let requestBody: [String: Any] = ["input": input, "voice": voice, "audioConfig": audioConfig]
                        let requestBodyData = try! JSONSerialization.data(withJSONObject: requestBody)
                
                     
                        request.httpBody = requestBodyData
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            guard let data = data else {
                                print("Error: \(error!)")
                                return
                            }

                            let responseJSON = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
                            if let audioContent = responseJSON["audioContent"] as? String,
                               let audioData = Data(base64Encoded: audioContent) {
                                
                        
                                self.playAudio(fromData: audioData)
                            }
                        }
                        
                        task.resume()
             }

                func fetchVoiceData(completion: @escaping (Voice?) -> Void) {
                    let apiKey = "AIzaSyDf2LDCrnMC1fnEaZN5-iNYh8f9EOMjH1I"
                    let url = URL(string: "https://texttospeech.googleapis.com/v1/text:synthesize?key=\(apiKey)")!
                    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                        if let data = data {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let voiceData = try? decoder.decode(Voice.self, from: data)
                            completion(voiceData)
                        } else {
                            completion(nil)
                        }
                    }
                    task.resume()
                }

            struct Voice: Decodable {
                    let audioConfig: AudioConfig
                    let input: Input
                    let voice: VoiceClass
                }

                // MARK: - AudioConfig
                struct AudioConfig: Decodable {
                    let audioEncoding: String
                    let effectsProfileID: [String]
                    let pitch, speakingRate: Double

                    enum CodingKeys: String, CodingKey {
                        case audioEncoding
                        case effectsProfileID = "effectsProfileId"
                        case pitch, speakingRate
                    }
                }

                // MARK: - Input
                struct Input: Decodable {
                    let text: String
                }

                // MARK: - VoiceClass
                struct VoiceClass: Decodable {
                    let languageCode, name: String
                }
                
                func playAudio(fromData audioData: Data) {
                    do {
                        player = try AVAudioPlayer(data: audioData)
                        player?.prepareToPlay()
                        player?.play()
                    } catch {
                        print("Error playing audio: \(error)")
                    }
                }
         
        }

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date


}

