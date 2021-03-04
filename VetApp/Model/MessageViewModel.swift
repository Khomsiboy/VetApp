//
//  MessageViewModel.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-31.
//

import Foundation
import Firebase
import FirebaseStorage

struct Message : Codable , Identifiable {
    var id : String?
    var content : String
    var name : String
    var imageBool : Bool
}

class MessageViewModel : ObservableObject{
    
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    private var image : UIImage?
    
    func sendMessage(messageContent : String, docId : String){
         
        if user != nil {
            db.collection("chatrooms").document(docId).collection("messages").addDocument(data: [
                "sentAt" : Date(),
                "displayName" : user!.email,
                "content" : messageContent,
                "sender" : user!.uid
            ])
        }
        
    }
    
    func sendPhoto(uiImage : UIImage, docId : String){
        
        
                  let imageName = UUID().uuidString + ".jpg"
       
                   let storage = Storage.storage().reference().child(imageName)
                   print("Image name: \(imageName)")
                   storage.putData((uiImage.jpegData(compressionQuality: 0.35))!, metadata: nil){
                       (_,err) in
       
                       if err != nil{
                           print((err?.localizedDescription)!)
                           return
                       }
       
                       print("Success")
       
                       storage.downloadURL { (url, err) in
                           if err != nil{
                               print((err?.localizedDescription)!)
                               return
                           }
       
                           guard let url = url else{
                               print((err?.localizedDescription)!)
                               return
                           }
                        
                        if self.user != nil {
                            self.db.collection("chatrooms").document(docId).collection("messages").addDocument(data: [
                                "sentAt" : Date(),
                                "displayName" : self.user!.email,
                                "content" : url.absoluteString,
                                "ImageBool" : true,
                                "sender" : self.user!.uid
                            
                            ])
                        }
                        
                        
                       }
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
                    let imageBool = data["ImageBool"]
                    return Message(id: docId, content: content, name: displayName,imageBool: (imageBool != nil))
                    
                }
                
                
                
            })
        }
        
    }
    
}
