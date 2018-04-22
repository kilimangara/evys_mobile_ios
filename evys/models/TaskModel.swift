//
//  TaskModel.swift
//  evys
//
//  Created by Nikita Zlain on 22.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

struct TaskModel: Decodable {
    
    let id: Int
    let name: String
    let task: String
    let tip: String
    let type: String
    let answers: [AnswerModel]
    
}

struct AnswerModel: Decodable {
    
    let content: String
}
