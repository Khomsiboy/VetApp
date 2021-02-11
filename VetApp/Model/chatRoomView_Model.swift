//
//  chatRoomView_Model.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-31.
//

import Foundation
import Firebase

struct ChatRoom : Codable,Identifiable {
    
    var id : String
    var title : String
    var joinCode : Int
    
}

class ChatRoomViewModel : ObservableObject{
    
    
    @Published var chatRooms = [ChatRoom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    
    func fetchData(){
        
        if user != nil {
            db.collection("chatrooms").whereField("user",arrayContains: user!.uid).addSnapshotListener({(snapshot,error) in
                guard let documents = snapshot?.documents else {
                    print("no document")
                    return
                }
                
                
                self.chatRooms = documents.map({ docSnapshot -> ChatRoom in
                    
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let joinCode = data["joinCode"] as? Int ?? -1
                    return ChatRoom(id: docId, title: title, joinCode: joinCode)
                    
                })
            })
        }
        
    }
    
    
    func createChatRoom(title : String ,handler :@escaping () -> Void){
        if user != nil {
            db.collection("chatrooms").addDocument(data: [
                "title" : title,
                "joinCode" : Int.random(in: 1000..<9999),
                "user" : [user!.uid]]) { err in
                
                if let err = err{
                    print("Connot add docs! \(err)")
                }
                else{
                    handler()
                }
                
            }
        }
    }
    
    
    func joinChatroom(code : String, handler :@escaping () -> Void){
        if user != nil {
            db.collection("chatrooms").whereField("joinCode", isEqualTo: Int(code)).getDocuments() {(snapshot , error) in
                if let error = error{
                    print("Error getting docs \(error)")
                }else{
                    for documents in snapshot!.documents{
                        self.db.collection("chatrooms").document(documents.documentID).updateData([
                            "user" : FieldValue.arrayUnion([self.user!.uid])])
                        handler()
                    }
                }
                
            }
        }
    }
    
}
