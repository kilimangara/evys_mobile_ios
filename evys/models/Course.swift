//
//  Course.swift
//  evys
//
//  Created by Nikita Zlain on 15.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation


struct Course {
    
    let type: String
    let id: Int
    let progress: Int8
    let target: Int8
    let subjectName: String
    
    init(type: String, id: Int, progress: Int8, target: Int8, subjectName: String){
        self.type = type
        self.progress = progress
        self.target = target
        self.subjectName = subjectName
        self.id = id
    }
    
}
