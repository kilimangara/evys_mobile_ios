//
//  CourseTableViewCell.swift
//  evys
//
//  Created by Nikita Zlain on 15.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import CircleProgressBar

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var progressBarView: CircleProgressBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
