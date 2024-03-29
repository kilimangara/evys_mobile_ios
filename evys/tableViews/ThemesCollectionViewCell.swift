//
//  ThemesCollectionViewCell.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit

class ThemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var themeNumLabel: UILabel!
    
    @IBOutlet weak var underLabelView: UIView!
    let colorsArray = [
        UIColor.orange,
        UIColor.purple,
        UIColor.brown,
        UIColor.red
    ]
    
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
    
    func setDynamicValues(themeModel: ThemeModel){
      themeNumLabel.text = String(themeModel.themeInfo.num)
      themeNameLabel.text = themeModel.themeInfo.name
    }
    
    func prepareView(){
        let randomIndex = Int(arc4random_uniform(UInt32(colorsArray.count)))
        underLabelView.backgroundColor = colorsArray[randomIndex]
        underLabelView.layer.cornerRadius = 24
        layer.cornerRadius = 4
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.8    }
}
