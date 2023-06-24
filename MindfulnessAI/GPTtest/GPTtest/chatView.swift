//
//  chatView.swift
//  GPTtest
//
//  Created by Elliot Rapp on 6/20/23.
//

import SwiftUI
import Foundation

struct ChatView: View {
    
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.messages.filter({$0.role != .system}),
                        id: \.id) { message in
                    messageView(message: message)
                }
                        .frame(width:280, height: 400)
            }
    
            HStack {
                TextField("enter a message:", text: $vm.currentInput)
                
                Button(action: {
                    vm.sendMessage()
                } ,
                       label: {
                    Text("Send")
                })
                .buttonStyle(.borderless)
                .frame(width: 150, height: 150)
                .padding()
                
            }
        }
        .padding()

    }
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user {Spacer()}
            Text(message.content)
            if message.role == .assistant {Spacer()}
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
