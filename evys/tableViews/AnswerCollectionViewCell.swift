//
//  AnswerCollectionViewCell.swift
//  evys
//
//  Created by Nikita Zlain on 20.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = false
    }

}
