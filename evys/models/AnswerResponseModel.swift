//
//  AnswerModel.swift
//  evys
//
//  Created by Nikita Zlain on 22.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation

struct AnswerResponseModel: Decodable {
    
    let blockEnd: Bool
    
    let changeBlockId: Int?
    
    let answerData: AnswerDataModel
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        blockEnd = try values.decode(Bool.self, forKey: .blockEnd)
        changeBlockId = try values.decodeIfPresent(Int.self, forKey: .changeBlockId)
        answerData = try values.decode(AnswerDataModel.self, forKey: .answerData)
    }
    
    enum CodingKeys: String, CodingKey {
        case blockEnd = "block_end"
        case changeBlockId = "change_block_id"
        case answerData = "answer_data"
    }
}

struct AnswerDataModel: Decodable {
    
    let isRight: Bool
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isRight = try values.decode(Bool.self, forKey: .isRight)
    }
    
    enum CodingKeys:String, CodingKey {
        case isRight = "is_right"
    }
}
