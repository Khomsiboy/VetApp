//
//  MessagesScreenView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-01.
//

import SwiftUI

struct MessagesScreenView: View {
    let chatroom : ChatRoom
    
    @ObservedObject var messages = MessageViewModel()
    @State var messagesValue = ""
    
    
    init(chatroom : ChatRoom) {
        self.chatroom = chatroom
        messages.getMessages(docId: chatroom.id)
    }
    
    var body: some View {
        VStack{
            List(messages.messages){ message in
                HStack{
                    Text(message.conent)
                    Spacer()
                }
            }
            
            HStack{
                
                TextField("Enter Message...", text : $messagesValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    messages.sendMessage(messageContent: messagesValue, docId: chatroom.id)
                }, label: {
                    Text("Send")
                })
            }
            
        }
        .navigationBarTitle(chatroom.title)
    }
}

struct MessagesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesScreenView(chatroom: ChatRoom(id: "101", title: "Test", joinCode: 123))
    }
}
