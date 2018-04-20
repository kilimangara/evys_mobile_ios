//
//  TestCardView.swift
//  evys
//
//  Created by Nikita Zlain on 20.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TestCardView: UIView {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var taskTextField: UITextView!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var collectionAnswerView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func setRootViewShadow() {
        layer.cornerRadius = 25.0
        rootView.layer.cornerRadius = 25.0
        rootView.layer.borderWidth = 1
        rootView.layer.borderColor = UIColor.clear.cgColor
        rootView.layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.3)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
        cornerRadius: rootView.layer.cornerRadius).cgPath
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("TestCardView", owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = self.bounds
        setRootViewShadow()
        taskTextField.layer.borderColor = UIColor.black.cgColor
        taskTextField.layer.borderWidth = 0.5
        taskTextField.layer.cornerRadius = 5
        rootView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        collectionAnswerView.register(UINib(nibName:"AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "answerCell")
        Observable.just(["Первое", "Второе", "ТРЕТЬЕ", "ЧЕТВЕРТОЕ", "Первое", "Второе", "ТРЕТЬЕ", "ЧЕТВЕРТОЕ"]).asDriver(onErrorJustReturn: []).drive(collectionAnswerView.rx.items(cellIdentifier: "answerCell")) {
            index, answer, cell in
            if let answerCell = cell as? AnswerCollectionViewCell {
                answerCell.answerLabel.text = answer
                answerCell.prepareCell()
            }
        }
        let transform = CATransform3DIdentity
        let offsetPositioning = CGPoint(x: 0, y: rootView.bounds.height )
        layer.transform =  CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0)
        layer.opacity = 0.2
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.layer.transform = CATransform3DIdentity
            self.layer.opacity = 1
        }, completion: nil)
    }
    
    public func rightAnswerAnimation(completionHandler: ((Bool) -> (Void))?) {
        let offsetPositioning = CGPoint(x: rootView.bounds.width, y: 0 )
        layer.transform =  CATransform3DIdentity
        layer.opacity = 1
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut, animations: {
            self.layer.transform = CATransform3DTranslate(CATransform3DIdentity, offsetPositioning.x, offsetPositioning.y, 0)
            self.layer.opacity = 0
        }, completion: completionHandler)
    }

}
