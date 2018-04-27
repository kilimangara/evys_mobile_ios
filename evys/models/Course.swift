//
//  Course.swift
//  evys
//
//  Created by Nikita Zlain on 15.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

struct Course: Decodable {
    
    let type: String
    let id: Int
    let progress: Int8
    let target: Int8
    let subject: Subject
    
}

struct Subject: Decodable {
    
    let subject: String
}
