//
//  MessageViewModel.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-31.
//

import Foundation
import Firebase

struct Message : Codable , Identifiable {
    var id : String?
    var conent : String
    var name : String
}

class MessageViewModel : ObservableObject{
    
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func sendMessage(messageContent : String , docId : String){
        
        if user != nil {
            db.collection("chatrooms").document(docId).collection("messages").addDocument(data: [
                "sentAt" : Date(),
                "displayName" : user!.email,
                "content" : messageContent,
                "sender" : user!.uid
            ])
        }
        
    }
    
    func getMessages(docId:String){
        
        if user != nil {
            db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt",descending: false).addSnapshotListener({(snapshot , error ) in
                guard let documents = snapshot?.documents else{
                    print("no document found")
                    return
                }
                
                self.messages = documents.map{ docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = data["content"] as? String ?? ""
                    let displayName = data["displayName"] as? String ?? ""
                    return Message(id: docId, conent: content, name: displayName)
                    
                }
                
                
                
            })
        }
        
    }
    
}
