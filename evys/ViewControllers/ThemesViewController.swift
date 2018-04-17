//
//  ThemesViewController.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    var courseModel: Course!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = courseModel.subjectName
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
