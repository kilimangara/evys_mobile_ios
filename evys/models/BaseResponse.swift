//
//  BaseResponse.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

class BaseResponse<T: Decodable>: Decodable {
    
    let data: T?
    let error: ErrorModel?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        error = try values.decodeIfPresent(ErrorModel.self, forKey: .error) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case data
        case error
    }
}
