//
//  LoginViewController.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var applyButton: UIButton!
    
    let disposable = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyButton.layer.cornerRadius = 5
        if let persistedPhone = PersistenceManager.sharedInstance.getPhone() {
            self.phoneNumberField.text = persistedPhone
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyPressed(_ sender: UIButton) {
        self.phoneNumberField.resignFirstResponder()
        if let textValue = self.phoneNumberField.text {
            print(textValue)
            APIProvider.sharedInstance.sendCode(phone: "+7"+textValue)
                .subscribe(onNext: { value in
                    PersistenceManager.sharedInstance.savePhone(phone: textValue)
                    self.performSegue(withIdentifier: "toCodeSegue", sender: self)
                }, onError: {
                    error in
                    print(error)
                }).disposed(by: self.disposable)
        }
    }
    
    private func onNextFired(){
        performSegue(withIdentifier:"toCodeSegue" , sender: self)
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
