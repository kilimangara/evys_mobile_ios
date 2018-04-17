//
//  CodeViewController.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import RxSwift

class CodeViewController: UIViewController {

    @IBOutlet weak var codeField: UITextField!
    
    @IBOutlet weak var applyButton: UIButton!
    
    let disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyCodePresed(_ sender: UIButton) {
        self.codeField.resignFirstResponder()
        if let textValue = self.codeField.text {
            print(textValue)
            if let phone = PersistenceManager.sharedInstance.getPhone(){
                APIProvider.sharedInstance.authStudent(phone: "+7"+phone, code: textValue).subscribe(onNext:{value in self.onNextFired(value: value)}, onError: {error in self.onErrorFired()})
                .disposed(by: self.disposable)
            }
        }
    }

    @IBAction func resendCodePressed(_ sender: UIButton) {
    }
    
    private func onNextFired(value: AuthModel){
        performSegue(withIdentifier: "mainAppFromLoginSegue", sender: self)
    }
    
    private func onErrorFired(){
        let alert = UIAlertController(title: "Ошибка", message: "Код введен неверно", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
