//
//  AuthModel.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

class AuthModel: Codable {
    
    let is_new: Bool
    let id: Int
    let token: String
    
    init(is_new: Bool, id: Int, token: String){
        self.is_new = is_new
        self.id = id
        self.token = token
        PersistenceManager.sharedInstance.saveToken(token: token)
    }
}
