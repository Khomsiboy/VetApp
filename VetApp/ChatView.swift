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
    
    @State var buttonState = false
    
    init() {
        ChatModel.fetchData()
    }
    
    var body : some View {
           
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false, content:{
                ForEach(ChatModel.chatRooms){ chatroom in
                    HStack {
                        
                        NavigationLink(destination: MessagesScreenView(chatroom: chatroom)){
                           
                            HStack{
                                Text(chatroom.title)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("Color1"))
                            .clipShape(Capsule())
                            
                            
                            
                        }
                        Spacer()
                        
                        if !buttonState{
                            
                            Button(action: {
                               
                                self.buttonState = true
                            }, label: {
                                Image(systemName: "checkmark.circle")
                                    
                            })
                            .padding(.trailing,20)
                            
                           
                            
                        }else{
                            Button(action: {
                                self.buttonState = false
                            }, label: {
                                Image(systemName: "checkmark.circle.fill")
                                    
                            })
                            .padding(.trailing,20)
                            
                        }
                       
                    }.padding(.vertical,5)
                    .padding(.leading,5)
                     
                    
            }.navigationBarTitle("Meddelanden")
        })
            
           
         .navigationBarItems(trailing: Button(action: {
            self.JoinModel = true
        }, label: {
           Image(systemName: "plus.bubble")
            
        })).sheet(isPresented: $JoinModel, content: {
            Join(isOpen: $JoinModel)
        })
            
        }.onAppear{
            //UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)
            
        }
        
    }
    
    
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
