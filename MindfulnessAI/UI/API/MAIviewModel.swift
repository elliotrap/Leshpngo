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
    
    @ObservedObject var counter = Counter()
    
    @ObservedObject var voice = ChatViewModel()
    
    @Published var loginUsernameText: String = ""
    @Published var startLessonPrompt = true
    @Published var startMeditationPrompt = true

    
   
    

    @Published var tenMinuetButton = true
    @Published var twentyMinuetButton = false
    @Published var thirtyMinuetButton = false

    @Published var minutes = 0
    
    @Published private var client: OpenAISwift?
    @Published var prompt =
    """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
"""
    

    @Published var meditation = ""
    @Published var models = [String]()
    
    @Published var isLoading: Bool = false
    

    @Published var promptIndex = 0
    @Published var prompts = [
        """
    foo(x, y, &z);
    char *s = "Hello world"; printf("%s\n", s);
    point p = {x, y}; color c = RED;
    for (int i = 0; i < z; i++) {
        printf("%d\n", i); if (i % 2 == 0) {
            continue; } else { break;
    foo(x, y, &z);
        char *s = "Hello world"; printf("%s\n", s);
        point p = {x, y}; color c = RED;
    
            for (int i = 0; i < z; i++) {
            printf("%d\n", i); if (i % 2 == 0) {
                continue; } else { break;
        }
    }
    """,

    """
    char *s = "Hello world"; printf("%s\n", s);
            continue; } else { break;
    printf("%d\n", i); if (i % 2 == 0) {
    point p = {x, y}; color c = RED;
        low = 0
        high = len(lengths) - 1
        while low <= high:
            mid = (low + high) // 2
            if lengths[mid] >= num:
                high = mid - 1
            else:
                low = mid + 1
     n = len(s)
     dp = [False] * (n + 1)
     dp[0] = True if lengths[mid] >= num:
     for i in range(1, n + 1):
}
""",
        """
     n = len(s)
     dp = [False] * (n + 1)
     
dp[0] = True if lengths[mid] >= num:
     for i in range(1, n + 1):
         for j in range(i):
             if dp[j] and s[j:i] in dict:
                 dp[i] = True
                 break
        
if (cellDetails[i][j - 1].f == FLT_MAX
        || cellDetails[i][j - 1].f > fNew) {
                openList.insert(make_pair(
                fNew, make_pair(i, j - 1)));
                    point p = {x, y}; color c = RED;
                        low = 0
                        high = len(lengths) - 1
                        while low <= high:
            return dp[n]
""",
        """
else if (closedList[i - 1][j] == false
    && isUnBlocked(grid, i - 1, j) {
        gNew = cellDetails[i][j].g + 1.0;
        hNew = calculateHValue(i - 1, j);
        fNew = gNew + hNew;
    
for j in range(i):
        if dp[j] and s[j:i] in dict:
            dp[i] = True
                break
    
point p = {x, y}; color c = RED;
    if (cellDetails[i][j + 1].f == FLT_MAX
        || cellDetails[i][j + 1].f > fNew) {
            openList.insert(make_pair(
                fNew, make_pair(i, j + 1)));
"""]
    
    @Published var onesAndZerosIndex = 0

    @Published var onesAndZeros = [
    """
    000100111010110110100001110001110110110100111010100100011110000111101010011101011011010000111010111010100100011110101001110101101101000011101011110101001000111101010011101011011010000111010111010100100100011110000111100001110000100001110101110101001000111101010011101011011010010111
    """,
    """
    111011000101001000111101010011101101111011101011011010000111010111010010001110011101001010011101011011010011101010010001000011101011101010010001101101010011101011011010000111111100100100011110010001000011111110010010001111001010111010010001110011101001010011101011011010101001101010
    """,
    """
    010100100011110101001110101101101000011101011100011110010100100010000111010111010100100011110101001110101101111101011011010000111010000100011110111000111011011010011101010010001111000011110000111000001111111001001000111100100000010011101011011010000111000111011011010010110100111110
    """,
    """
    010100100011110101001110101101101000011101011010110110100001110101110100100011100111010010100111010110110100111010100100010000111010111010100100010111010100111010110110100001111111001001000111100100001111111001001000111100100011101100010100100011110101001110110111101110110010101001
    """]
    
    
    @Published var synthesizer = AVSpeechSynthesizer()
    let realm = try! Realm()
    
    @Published var maxHeight: CGFloat = UIScreen.main.bounds.height / 3.30
    @Published var sliderProgress: CGFloat = 0
    @Published var sliderHeight: CGFloat = 0
    @Published var lastDragValue: CGFloat = 0
    
    @Published var lessonMaxHeight: CGFloat = UIScreen.main.bounds.height / 3.30
    @Published var lessonSliderProgress: CGFloat = 0
    @Published var lessonSliderHeight: CGFloat = 0
    @Published var lessonLastDragValue: CGFloat = 0
    
    @Published var minuteMaxHeight: CGFloat = UIScreen.main.bounds.height / 4.45
    @Published var minuteSliderProgress: CGFloat = 1
    @Published var minuteSliderHeight: CGFloat = 0
    @Published var minuteLastDragValue: CGFloat = 0
    // API key
    func setup() {
        client = OpenAISwift(authToken: "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")
        
    }
    // pariameters for the API call
        func send(text: String, completion: @escaping (String) -> Void) {
            client?.sendCompletion(with: text, maxTokens: 200, completionHandler: { result in // parameters
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
        isLoading = true
        
        send(text: prompt) { response in
            DispatchQueue.main.async {
                self.models.append(response)
                self.isLoading = false
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
        
    func testVoice() {
        counter.start()
        let utterance = AVSpeechUtterance(string:     """
You are vipassana meditation expert training people through an app. give me a non metaphysical meditation for an experienced meditator. Provide three dots "..." to identify a pause for silence after each section; let there be five and only 5 pauses in the meditation, each pause is 2 minutes so the meditation will last 10 minutes. Also don't number each section of the meditation.
""")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.01
        let synthesize = AVSpeechSynthesizer()
        
        synthesizer.speak(utterance)
        counter.stop()
    }
    
    func aiVoices(_ script: String, withPause pause: TimeInterval) {
            let segments = script.components(separatedBy: "...")
            let synthesizer = AVSpeechSynthesizer()
            
            var segmentIndex = 0
            
            func speakNextSegment() {
                
                
                counter.start()
                
                guard segmentIndex < segments.count else { return }
                
                let segment = segments[segmentIndex]
                let utterance = AVSpeechUtterance(string: segment)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
                utterance.rate = 0.3
                synthesizer.speak(utterance)
                
                segmentIndex += 1
                
                counter.stop()
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
    


    func startNewCounter() {
        let counter = Counter()
        counter.start()

        try! realm.write {
            realm.add(counter)
        }
    }
    }

