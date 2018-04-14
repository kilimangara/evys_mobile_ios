//
//  AuthModel.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

class AuthModel {
    
    let is_new: Bool
    let id: Int
    let token: String
    
    init(is_new: Bool, id: Int, token: String){
        self.is_new = is_new
        self.id = id
        self.token = token
        PersistenceManager.sharedInstance.saveToken(token: token)
    }
    
    init(dict: Dictionary<String, AnyObject>){
        self.is_new = dict["is_new"]
        self.id = dict["id"]
        self.token = dict["token"]
        PersistenceManager.sharedInstance.saveToken(token: self.token)
    }
}
