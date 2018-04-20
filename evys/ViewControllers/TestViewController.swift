//
//  TestViewController.swift
//  evys
//
//  Created by Nikita Zlain on 20.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var testCardView: TestCardView!
    
    @IBOutlet weak var incorrectAnserView: UIView!
    
    @IBOutlet weak var correctAnswerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareIndicatorViews()
        showCorrectAnswerAnimation()
        let cardFrame = CGRect(x: view.center.x - 336/2, y: view.center.y - 503/2, width:336 , height: 503)
        testCardView = TestCardView(frame:cardFrame)
        view.addSubview(testCardView)
        testCardView.rightAnswerAnimation(completionHandler: {
            end in
            self.testCardView.removeFromSuperview()
            self.testCardView = TestCardView(frame: cardFrame)
            self.view.addSubview(self.testCardView)
        })

        // Do any additional setup after loading the view.
    }
    
    func prepareIndicatorViews(){
        incorrectAnserView.layer.cornerRadius = 32
        incorrectAnserView.layer.zPosition = 5
        correctAnswerView.layer.cornerRadius = 32
        correctAnswerView.layer.zPosition = 5
    }
    
    func showCorrectAnswerAnimation() {
        UIView.animate(withDuration: 0.2, delay: 2, options: .curveEaseInOut, animations: {
           self.correctAnswerView.center.y -= 50
           self.correctAnswerView.layer.opacity = 1
        }, completion: {
            ended in
            UIView.animate(withDuration: 0.2, delay: 2, options: .curveEaseInOut, animations: {
                self.correctAnswerView.center.y += 50
                self.correctAnswerView.layer.opacity = 0
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
