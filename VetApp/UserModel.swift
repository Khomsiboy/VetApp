//
//  UserModel.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-03-01.
//

import Foundation

class UserModel {
    var uid : String
    var email : String?
    var displayName : String?
    
    init(uid : String, displayname : String? , email : String?) {
        
        self.uid = uid
        self.email = email
        self.displayName = displayname
    }
}
