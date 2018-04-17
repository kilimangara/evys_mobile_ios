//
//  CourseTableViewCell.swift
//  evys
//
//  Created by Nikita Zlain on 15.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import LinearProgressBar

class CourseTableViewCell: UICollectionViewCell {

    @IBOutlet weak var linearProgressBarView: LinearProgressBar!
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    func prepareForAppearance(boundsWidth: CGFloat, index: Int){
        let rotationAngleDegrees : Double = -30
        let rotationAngleRadians = rotationAngleDegrees * (Double.pi/180)
        let offsetPositioning = CGPoint(x: boundsWidth, y: -20)
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, CGFloat(rotationAngleRadians), -50, 0, 1)
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50)
        
        layer.transform = transform
        layer.opacity = 0.2
        let delay = 0.06 * Double(index)
        UIView.animate(withDuration:0.8, delay:delay , usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: { () -> Void in
            self.layer.transform = CATransform3DIdentity
            self.layer.opacity = 1
        }) { (Bool) -> Void in
            
        }
    }
    
    func prepareView(){

        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: contentView.layer.cornerRadius).cgPath
    }

}
