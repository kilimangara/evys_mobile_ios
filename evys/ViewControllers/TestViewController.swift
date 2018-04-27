//
//  TestViewController.swift
//  evys
//
//  Created by Nikita Zlain on 20.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TestViewController: UIViewController {

    var testCardView: TestCardView!
    
    let disposables = DisposeBag()
    
    var testBlockId: Int?
    
    var themeId: Int!
    
    @IBOutlet weak var incorrectAnserView: UIView!
    
    @IBOutlet weak var correctAnswerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareIndicatorViews()
        if testBlockId == nil {
            loadTestBlock()
        }
    }
    
    func loadTestBlock() {
        APIProvider.sharedInstance.generateTest(themeId: themeId).take(1).subscribe(onNext: {
            tbId in
            self.testBlockId = tbId
            self.loadNextTest()
        }).disposed(by: disposables)
    }
    
    func createCardView(taskModel: TaskModel){
        print("CREATE CARDVIEW")
        let cardFrame = CGRect(x: view.center.x - 336/2, y: view.center.y - 503/2, width:336 , height: 503)
        testCardView = TestCardView(frame: cardFrame)
        testCardView.passTestModel(taskModel: taskModel, modelSelected: answerPressed)
        view.addSubview(testCardView)
    }
    
    func answerPressed(timeSpent: Int, answer: String){
        APIProvider.sharedInstance.answerQuestion(themeId: themeId, testBlockId: testBlockId!, timeSpent: timeSpent, answer: answer).take(1).subscribe({
            result in
            switch(result){
            case .next(let answerModel):
                if answerModel.answerData.isRight {
                    self.showCorrectAnswerAnimation()
                    self.testCardView.rightAnswerAnimation(completionHandler: {
                        ended in
                        self.loadNextTest()
                        self.testCardView.removeFromSuperview()
                    })
                } else {
                    self.showIncorrectAnswerAnimation()
                    self.testCardView.incorrectAnswerAnimation(completionHandler: {
                        ended in
                        self.loadNextTest()
                        self.testCardView.removeFromSuperview()
                    })
                }
            case .error(_):
                break
            case .completed:
                break
            }
        }).disposed(by: disposables)
    }
    
    func loadNextTest() {
        APIProvider.sharedInstance.getQuestion(themeId: themeId, testBlockId:testBlockId!).take(1).subscribe({
            result in
            switch(result){
            case .next(let taskModel):
                self.createCardView(taskModel: taskModel)
            case .error(_):
                break
            case .completed:
                break
            }
        }).disposed(by: disposables)
    }
    
    func prepareIndicatorViews(){
        incorrectAnserView.layer.cornerRadius = 32
        incorrectAnserView.layer.zPosition = 5
        correctAnswerView.layer.cornerRadius = 32
        correctAnswerView.layer.zPosition = 5
    }
    
    func showCorrectAnswerAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
           self.correctAnswerView.center.y -= 50
           self.correctAnswerView.layer.opacity = 1
        }, completion: {
            ended in
            UIView.animate(withDuration: 0.2, delay: 1.5, options: .curveEaseInOut, animations: {
                self.correctAnswerView.center.y += 50
                self.correctAnswerView.layer.opacity = 0
            }, completion: nil)
        })
    }
    
    func showIncorrectAnswerAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.incorrectAnserView.center.y -= 50
            self.incorrectAnserView.layer.opacity = 1
        }, completion: {
            ended in
            UIView.animate(withDuration: 0.2, delay: 1.5, options: .curveEaseInOut, animations: {
                self.incorrectAnserView.center.y += 50
                self.incorrectAnserView.layer.opacity = 0
            }, completion: nil)
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let testCardViewUnwrapped = testCardView {
            testCardViewUnwrapped.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
