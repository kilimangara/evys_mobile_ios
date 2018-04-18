//
//  ThemeModel.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

struct ThemeModel: Decodable {
    
    let id: Int
    let progress: Int
    let repetitionProgress: Int
    let themeInfo: ThemeInfoModel
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        progress = try values.decode(Int.self, forKey: .progress)
        repetitionProgress = try values.decode(Int.self, forKey: .repetitionProgress)
        themeInfo = try values.decode(ThemeInfoModel.self, forKey: .themeInfo)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case progress
        case repetitionProgress = "repetition_progress"
        case themeInfo = "theme"
    }
    
}

struct ThemeInfoModel: Decodable {
    let id: Int
    let name: String
    let num: Int
}
