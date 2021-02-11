//
//  ChatView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import SwiftUI

struct Chat: View {

    @ObservedObject var ChatModel = ChatRoomViewModel()
    @State var JoinModel = false
    
    init() {
        ChatModel.fetchData()
    }
    
    var body : some View {
        
        NavigationView{
            List(ChatModel.chatRooms){ chatroom in
            NavigationLink(destination: MessagesScreenView(chatroom: chatroom)){
                   
                    HStack{
                        Text(chatroom.title)
                    }
                    
                    
              }
        }.navigationBarTitle("Meddelanden")
         .navigationBarItems(trailing: Button(action: {
            self.JoinModel = true
        }, label: {
           Image(systemName: "plus.bubble")
            
        })).sheet(isPresented: $JoinModel, content: {
            Join(isOpen: $JoinModel)
        })
        }
        
    }
    
    
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
