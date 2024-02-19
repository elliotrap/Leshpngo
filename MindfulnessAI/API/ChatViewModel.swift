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
import RealmSwift
import Combine
import CoreAudio
class ChatViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate, AVAudioPlayerDelegate  {




    override init() {
        super.init()
        
        do {
            // Attempt to initialize Realm
            let realm = try RealmManager.shared.getRealm() // Assuming `getRealm()` is a method that returns `Realm?`
            
            // Fetch data and set up Realm notifications
            fetchData()
            
            let meditations = realm.objects(Item.self)
            // Observe for changes
            notificationToken = meditations.observe { [weak self] _ in
                self?.updateSavedMeditationsStatus()
            }
            
            updateSavedMeditationsStatus()
        } catch {
            // Handle initialization error
            print("Realm initialization failed: \(error)")
            // Consider more user-friendly error handling here, depending on your app's structure
        }
    }



        deinit {
            notificationToken?.invalidate()
            meditationTimer?.invalidate()
            meditationTimer = nil
        }

        func updateSavedMeditationsStatus() {
            let realm = try! Realm()
            let savedMeditations = realm.objects(Item.self)
            self.hasSavedMeditations = !savedMeditations.isEmpty
        }
    

    
    private var notificationToken: NotificationToken?

    static var shared = ChatViewModel()
    
    private var realm = LoginLogout()
    
    private let openAIService = OpenAIService()
    
    private var viewModelTwo = OpenAIService()
    
    
   
    @Published var startMeditationPrompt = true

    @Published var startLessonPrompt = true
    
    @Published var hasSavedMeditations = true

    @Published var windowCase: Bool = false

    @Published var firstItemButton = false

    @Published var chosenMeditation = "Vipas"
    
    @Published var chosenInstructor = "Chief"
    
    @Published var profileButtonPressed: Bool = false
    
    @Published var durationButtonPressed: Bool = false
    
    @Published var databaseAccess = false
    
    @Published var darkmode = false
    
    @Published var meditationDuration: TimeInterval = 0
        
    @Published var counter: Int = 0

    @Published var isPaused = true
    
    @Published var ttsIsTalking = false
    
    @Published var GPTLoading = false
    
    @Published var latestAssistantMessage: String = ""
    
    @Published var contentMessage: String = """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
    
            @Published var messages: [Message] = []
            
            @Published var currentInput: String = ""
    
    var player: AVAudioPlayer?
    
    private var startDate: Date?
    
    var currentItem: Item?
            
    var meditationTimer: Timer?
    
    @Published var randomText = ""
    let characters = ["0", "1"]
    
    @Published var items: [Item] = [] // Replace with your actual data fetching logic
    @Published var dynamicHeight: CGFloat = 100

    private let buttonHeight: CGFloat = 50
    private let baseHeight: CGFloat = 670


    private func fetchData() {
        // Fetch items from Realm and assign to 'items'
        @ObservedResults(Item.self) var items

    }

    
    
    private var extraHeightPerItem: CGFloat {
        return buttonHeight
    }
    
     private func updateDynamicHeight() {
         let extraItems = max(0, items.count - 6)
         dynamicHeight = baseHeight + CGFloat(extraItems) * extraHeightPerItem
     }

     // Call this method whenever the list of items changes
     func onItemsUpdated() {
         updateDynamicHeight()
     }
    
    private func startFlickeringEffect() {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                self.randomText = (0..<50).map { _ in self.characters.randomElement() ?? "0" }.joined()
            }
        }
    
    

        func sendMessage(messageContent: String? = nil, systemContent: String? = nil) {
        
        let userMessageContent = messageContent ?? self.currentInput
            let systemMessageContent = systemContent ?? self.contentMessage
                
        let userMessage = Message(id: UUID(), role: .user, content: userMessageContent, createAt: Date())
         var systemMessage = Message(id: UUID(), role: .system, content: systemMessageContent, createAt: Date())

                currentInput = ""
                
                GPTLoading = true

                Task {
                    var tempMessages = messages
                         tempMessages.append(userMessage)  // Append only to a temporary array
                         let response = await openAIService.sendMessage(messages: tempMessages)
                    guard let receivedOpenAIMessage = response?.choices.first?.message else {
                        print("had no received message")
                        return
                    }
                    let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
                    
                    await MainActor.run { [unowned self] in
                        self.messages.append(receivedMessage)
                        latestAssistantMessage = receivedOpenAIMessage.content
                    }
                    GPTLoading = false
                }
            }
            
    func textToSpeech(ssmlText: String) {
       //let apiKey = "AIzaSyDf2LDCrnMC1fnEaZN5-iNYh8f9EOMjH1I"

        let googleApiKey: String = APIManager.ConstantsUserGoogleAPIKey.GoogleApiKey

        let url = URL(string: "https://texttospeech.googleapis.com/v1/text:synthesize?key=\(APIManager.ConstantsUserGoogleAPIKey.GoogleApiKey)")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
           
                    let escapedResponseTextMajorPause = ssmlText.replacingOccurrences(of: "+2", with: "<break time=\"20s\"/>")
                    let escapedResponseTextMinorPause = ssmlText.replacingOccurrences(of: "...", with: "<break time=\"0.2s\"/>")

                   // let sssmlText = "<speak><prosody volume=\"soft\">This is spoken softly.</prosody></speak>"

                    let ssmlText = "<speak>\(escapedResponseTextMajorPause)\(escapedResponseTextMinorPause)</speak>"
                    
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

                        self.playAudio(fromData: audioData) { result in
                            switch result {
                            case .success:
                                print("Audio started successfully.")
                            case .failure(let error):
                                print("Failed to start audio: \(error)")
                                // Here you can add any additional handling or notifications about the failure.
                            }
                        }

            }
        }
                    task.resume()
    }
    
    func playAudio(fromData audioData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try AVAudioPlayer(data: audioData)
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()
            
            // UI-related tasks are dispatched on the main thread
            DispatchQueue.main.async {
                self.startMeditation()
                print("Is timer valid? \(self.meditationTimer?.isValid ?? false)")
            }
            
            completion(.success(()))
            
        } catch {
            print("Error playing audio: \(error)")
            
            // Call the completion handler with the error
            completion(.failure(error))
        }
    }


    @objc func timerFired() {
        meditationDuration += 1
        print("Timer fired. Meditation duration: \(meditationDuration) seconds.")
    }

    func startMeditation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Check if the timer is already running
            if self.meditationTimer == nil {
                print("Starting meditation timer...")
                
                self.meditationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerFired), userInfo: nil, repeats: true)
                
                // No need to add the timer to the main run loop when using `scheduledTimer`. It's added automatically.
            } else {
                print("Meditation timer is already running.")
            }
        }
    }



    func stopMeditation() {
            meditationTimer?.invalidate()
            meditationTimer = nil
            print("audio player did finish playing")
            updateTotalDuration(duration: meditationDuration)
            saveUsageToRealm(duration: meditationDuration)
        }

    func saveUsageToRealm(duration: TimeInterval) {
        print("saveUsageToRealm")
        
        do {
            let realm = try Realm()
            
            // Fetch the first user item or update an existing one
            var user = realm.objects(Item.self).first
            if user == nil {
                user = Item(name: "", isFavorite: false, savedId: 0) // Create a new user item if one doesn't exist
                user?.startDate = Date() // Set the start date for the new user item
            }
            // Try to write changes to the database
                  try realm.write {
                      user?.duration += duration
                      if user?.realm == nil {
                          realm.add(user!)
                      }
                  }
              } catch {
                  // Handle or log the error as per your needs
                  print("Error saving usage to Realm: \(error)")
              }
          }

    func updateTotalDuration(duration: TimeInterval) {
  
            // Try to initialize a Realm instance
            do {
                let realm = try Realm()
                
                // Fetch the first user item or create a new one if it doesn't exist
                // This seems to suggest a singleton pattern for a 'user' or global entry in the database.
                // Ensure this behavior is intended.
                var user = realm.objects(Item.self).first
                if user == nil {
                    user = Item() // Create a new user item if one doesn't exist in the database
                }

                // Try to write changes to the database
                try realm.write {
                    user?.duration += duration
                    if user?.realm == nil {
                        realm.add(user!)
                    }
                }
            } catch {
                // Handle or log the error as per your needs
                print("Error updating duration in Realm: \(error)")
            }
    }
    
    func retrieveMeditations() -> [Item] {
        let realm = try! Realm()
        let items = realm.objects(Item.self)
        return Array(items)
    }
    
    func getTotalDuration() -> TimeInterval {
        let realm = try! Realm()
        let user = realm.objects(Item.self).first
        return user?.duration ?? 0
    }

    func formatTotalDuration() -> String {
        let totalDuration = getTotalDuration()
        return formatDuration(totalDuration)
    }
    
    func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    
    func togglePauseResume() {
         if isPaused {
             // Resume playing
             player?.play()
         } else {
             // Pause playing
             player?.pause()
         }
         isPaused.toggle()
     }
    
    func justPause() {
        player?.pause()
    }
    
    func rewind15Seconds() {
        guard let player = player else { return }
        
        let currentTime = player.currentTime
        let newTime = max(currentTime - 15.0, 0)
        
        player.currentTime = newTime
    }
    
   
    
    func forward15Seconds() {
        guard let player = player else { return }
        
        let currentTime = player.currentTime
        let newTime = max(currentTime + 15.0, 0)
        
        player.currentTime = newTime
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
                
         
        }

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date


}
