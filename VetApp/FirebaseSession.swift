//
//  FirebaseSession.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import FirebaseAuth
import Firebase

struct User {
    var uid : String
    var email : String
}

struct UserData {
    
    var userName : String
    var userEmail : String
}

class Session : ObservableObject{
    
    @Published var sessionUser :User?
    @Published var isAnon: Bool = false
    @Published var data = [UserData]()
    private let db = Firestore.firestore()
    
    var handle: AuthStateDidChangeListenerHandle?
    let authRef = Auth.auth()
    
    func listen(){
        handle = authRef.addStateDidChangeListener({(auth,user) in
            if let user = user {
                self.isAnon = false
                self.sessionUser = User(uid: user.uid, email: user.email!)
            }else{
                self.isAnon = true
                self.sessionUser = nil
            }
            
        })
        
        
    }
    
    func signIn(email : String , password : String){
        authRef.signIn(withEmail: email, password: password){ authResult, error in
            print("Login state : \(authResult)")
        }
    }
    
    func signUp(email : String , password : String){
        authRef.createUser(withEmail: email, password: password) { authResult, error in
            print("Sign Up state : \(authResult)")
        }
    }
    
    func signOut() -> Bool{
        do{
            try authRef.signOut()
            self.sessionUser = nil
            self.isAnon = true
            return true
        } catch{
            return false
        }
    }
    
    func unbind(){
        if let handle = handle{
            authRef.removeStateDidChangeListener(handle)
        }
    }
    
    
    func createUser(userName: String, email: String){
        db.collection("User").document().setData(["UserName" : userName, "Email": email])
    }
    
    func getUserData(userEmail : String){
        db.collection("User").whereField("Email", isEqualTo: userEmail)
            .getDocuments(){ (QuerySnapshot, err) in
                
                if let err = err{
                    print("error getting docs \(err)")
                }else{
                    
                    var d = [UserData]()
                    
                    for document in QuerySnapshot!.documents{
                        let data = document.data()
                        let name = data["UserName"] as? String ?? ""
                        let email = data["Email"] as? String ?? ""
                        
                        d.append(UserData(userName: name, userEmail: email))

                    }
                    for doc in d {
                        print(doc.userEmail)
                    }
                    
                }
//                guard let documents = QuerySnapshot?.documents else {
//                    print("No Document found")
//                    return
//                }
//
//                self.data = documents.map({
//                    docSnapshot -> UserData in
//
//                    let data = docSnapshot.data()
//                    let docId = docSnapshot.documentID
//                    let email = data["Email"] as? String ?? ""
//                    let name = data["UserName"] as? String ?? ""
//                   // var User = UserData(userName: name, userEmail: email)
//                   // print("\(User.userName) , \(User.userEmail)")
//                    return UserData(userName: name, userEmail: email)
               // })
   }
    
}


}
