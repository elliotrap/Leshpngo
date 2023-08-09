//
//  chatViewModel.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 6/20/23.
//

import Foundation
import Alamofire
import SwiftUI

    
    
        class ChatViewModel: ObservableObject {

            @Published var GPTLoading = false

            
            @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
""", createAt: Date())]
            
            @Published var currentInput: String = """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
            
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
                    }
                     GPTLoading = false

                }
                
            }
        }
    
struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date


}
//extension MeditationGenerator {
//    class MeditationViewModel: ObservableObject {
//        @Published var meditationInit: [Message] = [Message(id: UUID(), role: .system, content: """
//You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
//""", createAt: Date())]
//        
//        @Published var currentMeditationInput: String = """
//You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
//"""
//        
//        private let openAIService = OpenAIService()
//        
//        func sendLessonMessage() {
//            var _ = Message(id: UUID(), role: .user, content: currentMeditationInput, createAt: Date())
//            currentMeditationInput = ""
//            
//            Task {
//                let response = await openAIService.sendMessage(messages: meditationInit)
//                guard let receivedOpenAIMessage = response?.choices.first?.message else {
//                    print("had no received message")
//                    return
//                }
//                let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
//                await MainActor.run {
//                    meditationInit.append(receivedMessage)
//                }
//            }
//            
//        }
//    }
//    
//}
