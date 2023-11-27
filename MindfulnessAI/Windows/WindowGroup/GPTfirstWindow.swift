//
//  GPTfirstWindow.swift
//  MindfulnessAI
//
//  Created by Elliot Rapp on 4/18/23.
//

import SwiftUI
import RealmSwift

extension UINavigationController {

    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 107 / 255, green: 214 / 255, blue: 110 / 255, alpha: 1.0)
       navigationItem.hidesBackButton = true
    }
}

struct ChatView: View {
    
    
    @ObservedObject var mode: Shapes
    @ObservedObject var vm = ViewModel()
    @ObservedObject var shapeVm = Shapes.shared
    @StateObject var realm = LoginLogout()
    @ObservedObject var viewModel = ChatViewModel.shared
    
    @ObservedRealmObject var group: BackendGroup
    let savedItems = Item.self
    
    
    @State var playing = true
    
    @State var pressedReset = true
    
    @State var startMeditation = true
    
    @State var gridSpacing: CGFloat = 10
    
    @State var startMeditationPrompt = false
    
    @State var vipassanaButtonPressed = true
    @State var expand: Bool = false
    @State var promptToggle: Bool = false
    
    @State var metaButtonPressed = false
    @State var expandTwo: Bool = false
    @State var promptToggleTwo: Bool = false
    
    @State var savedButtonPressed: Bool = false
    @State var expandThree: Bool = false
    
    
    @State var meditationTimeBoxAnimation = false
    @State var meditationTimeBoxExpand = false
    @State var menuPopUp = false
    @State var menuAnimationSizeChange = false
    
    
    @State var isLoading = false
    
    
    
    var body: some View {
        Group {
            if isLoading {
                
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            VStack {
                                ZStack {
               
                                    
                                    // name of the app
                                    Text("Léshpngo")
                                        .font(.system(size: 50))
                                        .font(.caption)
                                        .foregroundColor(Color("logoColor"))
                                        .zIndex(5)
                                        .modifier(Shapes.FlickeringBinaryBackground())
                                    
                                }
                            }
                            .padding(10)
                            .scaleEffect(1)
                            
                            
                            ChatViewTop(mode: Shapes(), group: group)
                            Spacer().frame(height: 10)
                            ChatViewTopMiddle(mode: Shapes(), group: group)
                            Spacer().frame(height: 20)
                            ChatViewBottomMiddle(mode: Shapes(), group: group)
                            Spacer().frame(height: 20)
                            ChatViewBottom(mode: Shapes(), group: group)
                        }
                        
                        
                        
                    }
                    .frame(minWidth: 900, maxWidth: 1000, minHeight: 700, maxHeight: 2500)
                    
                    .background(LinearGradient (
                        
                        gradient: Gradient(colors: [Color("offBlue"), Color("backgroundAppColor")]),
                        startPoint: .bottom,
                        endPoint: .top))
                    .environmentObject(shapeVm)
                    .environment(\.colorScheme, shapeVm.darkmode ? .dark : .light)
                    
                }                // Your main content view here
            }
        }
        .onAppear {
            // Simulate a loading process, such as fetching data
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // This delay represents the loading time
                // After loading is done, set isLoading to false
                isLoading = false
            }
        }
        
    }
}









struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        let group = BackendGroup()
        return Group {
            
            ChatView(mode: Shapes(), group: group)
        }
    }
}


