//
//  FirebaseSession.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import FirebaseAuth

struct User {
    var uid : String
    var email : String
}

class Session : ObservableObject{
    
    @Published var sessionUser :User?
    @Published var isAnon: Bool = false
    
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
        authRef.signIn(withEmail: email, password: password)
    }
    
    func signUp(email : String , password : String){
        authRef.createUser(withEmail: email, password: password) { authResult, error in
            print(authResult)
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
    
    
}
