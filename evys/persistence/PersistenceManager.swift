//
//  PersistenceManager.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    static let TOKEN_VALUE = "TOKEN"
    
    static let PHONE_VALUE = "PHONE"
    
    static let sharedInstance: PersistenceManager = {
        let instance = PersistenceManager()
        return instance
    }()
    
    let preferences: UserDefaults
    
    init(){
        self.preferences = UserDefaults.standard
    }
    
    public func saveToken(token: String){
        self.preferences.set(token, forKey: PersistenceManager.TOKEN_VALUE)
        preferences.synchronize()
    }
    
    public func getToken() -> String?{
        return self.preferences.string(forKey: PersistenceManager.TOKEN_VALUE)
    }
    
    public func savePhone(phone: String){
        self.preferences.set(phone, forKey: PersistenceManager.PHONE_VALUE)
        preferences.synchronize()
    }
    
    public func getPhone() -> String? {
        return self.preferences.string(forKey: PersistenceManager.PHONE_VALUE)
    }

}
