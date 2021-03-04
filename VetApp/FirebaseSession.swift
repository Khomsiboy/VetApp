//
//  FirebaseSession.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import FirebaseAuth
import Firebase

struct User : Identifiable{
    var id : String = UUID().uuidString
    var email : String
    var name : String
}

struct UserData : Identifiable {
    var id : String = UUID().uuidString
    var userName : String
    var userEmail : String
    var petName : String?
}

class Session : ObservableObject{
    
    @Published var sessionUser : User?
    @Published var sessionUserData : UserModel?
    @Published var isAnon: Bool = false
    @Published var isLogin: Bool = false
    @Published var userData : UserData? = nil
    private let db = Firestore.firestore()
    
    var handle: AuthStateDidChangeListenerHandle?
    let authRef = Auth.auth()
    
    
    
    func listen(){
        handle = authRef.addStateDidChangeListener({(auth,user) in
            if let user = user {
                self.isAnon = false
//                self.sessionUser = User(id: user.uid, email: user.email!, name: user.displayName!)
//                self.sessionUserData = UserModel(uid: user.uid, displayname: user.displayName, email: user.email!)
                if let userName = user.displayName{
                    self.userData = UserData(userName: userName, userEmail: user.email!)
                }
                
            }else{
                self.isAnon = true
                self.sessionUser = nil
                self.sessionUserData = nil
                self.userData = nil
            }
            
        })
        
        
    }
    
    func signIn( email : String , password : String){
        authRef.signIn(withEmail: email, password: password){ authResult, error in
            print("Login state : \(authResult)")
            if let err = error{
                print("Login error: \(err)")
               
            }else{
                self.isLogin = true
                self.getUserData()
            }
        }
        
    }
    
    func signUp(name: String , email : String , password : String, petName : String){
        authRef.createUser(withEmail: email, password: password) { authResult, error in
            print("Sign Up state : \(authResult)")
            if let err = error{
                print(" create user \(err)")
            }else{
                self.isLogin = true
                self.createUser(userName: name, email: email,petName: petName)
            }
           
        }
       
    }
    
    func signOut() -> Bool{
        do{
            try authRef.signOut()
            self.sessionUser = nil
            self.isAnon = true
            self.isLogin = false
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
    
    
    func createUser(userName: String, email: String, petName : String){
       // db.collection("User").document().setData(["UserName" : userName, "Email": email])
        db.collection("User").document(authRef.currentUser!.uid).setData(["UserName" : userName, "Email": email, "PetName" : petName])
        
    }
    
    func getUserData(){
        
        if let currentUser = authRef.currentUser?.uid{
            db.collection("User").document(currentUser).getDocument(){ (querySnapshot, err) in
                   
                   if let err = err{
                       print("error getting docs \(err)")
                   }else{
                       
                       
                      // for document in QuerySnapshot!.document{
                           let data = querySnapshot!.data()
                           let name = data?["UserName"] as? String ?? ""
                           let email = data?["Email"] as? String ?? ""
                           let pet = data?["PetName"] as? String ?? ""
                           
                       
                    self.userData = UserData(userName: name, userEmail: email, petName : pet)
                       print(self.userData?.userName)
                       print(self.userData?.userEmail)

                      
                   }
           }
        
        }
        
//        db.collection("User").whereField("Email", isEqualTo: authRef.currentUser).addSnapshotListener{(QuerySnapshot,error) in
//
//            guard let documents = QuerySnapshot?.documents else {
//                print("Not found")
//                return
//            }
//
//            self.sessionUser = documents.map { (documentQuery) -> User in
//                let data = documentQuery.data()
//                let name = data["UserName"] as? String ?? ""
//                let email = data["Email"] as? String ?? ""
//
//                return User(email: email, name: name)
//
//
//            }
//        }
                
               ///---------------------
                    
               // }
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



