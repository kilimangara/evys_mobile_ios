//
//  ErrorModel.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation


struct ErrorModel: Decodable {
    
    let description: String
    let type: String
    let statusCode: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decode(String.self, forKey: .description)
        type = try values.decode(String.self, forKey: .type)
        statusCode = try values.decode(Int.self, forKey: .statusCode)
    }
    
    enum CodingKeys : String, CodingKey {
        case statusCode = "status_code"
        case description
        case type
    }
}
