//
//  Join.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-31.
//

import SwiftUI

struct Join: View {
    
    @Binding var isOpen : Bool
    @State var joinCode = ""
    @State var newTilte = ""
    
    @ObservedObject var chatroomModel = ChatRoomViewModel()
    
    
    var body: some View {
        NavigationView{
            
            
            VStack{
                
                VStack{
                    Text("Join")
                        .font(.title)
                    TextField("Enter join code", text: $joinCode)
                        .padding()
                    Button(action: {
                        chatroomModel.joinChatroom(code: joinCode, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Join")
                    })
                }
                .padding(30)
                VStack{
                    Text("Create")
                        .font(.title)
                    TextField("Enter Title", text: $newTilte)
                        .padding()
                    Button(action: {
                        chatroomModel.createChatRoom(title: newTilte, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Create")
                    })
                }
                
            }
                
                .navigationBarTitle("Join")
        }
    }
}

struct Join_Previews: PreviewProvider {
    static var previews: some View {
        Join(isOpen: .constant(true))
    }
}
