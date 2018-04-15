//
//  CoursesViewController.swift
//  evys
//
//  Created by Nikita Zlain on 15.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CoursesViewController: UIViewController {
    
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    var coursesViewModel : CoursesViewModel?
    
    let disposables = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursesViewModel = CoursesViewModel()
        if let viewModel = coursesViewModel {
            viewModel.data.drive(coursesCollectionView.rx.items(cellIdentifier: "courseCell")) {
                _, course, cell in
                if let courseCell = cell as? CourseTableViewCell{
                    courseCell.subjectNameLabel.text = course.subjectName
                    courseCell.contentView.layer.cornerRadius = 4
                    courseCell.contentView.layer.borderWidth = 1
                    courseCell.contentView.layer.borderColor = UIColor.clear.cgColor
                    courseCell.contentView.layer.masksToBounds = false
                    courseCell.layer.shadowColor = UIColor.gray.cgColor
                    courseCell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                    courseCell.layer.shadowRadius = 4.0
                    courseCell.layer.shadowOpacity = 1.0
                    courseCell.layer.masksToBounds = false
                    courseCell.layer.shadowPath = UIBezierPath(roundedRect: courseCell.bounds,
                                                               cornerRadius: courseCell.contentView.layer.cornerRadius).cgPath
                }
            }.disposed(by: self.disposables)
        }
        
        coursesCollectionView.rx.modelSelected(Course.self).subscribe(onNext: {
            course in
            print(course.subjectName)
        }).disposed(by: self.disposables)
        
        // Do any additional setup after loading the view.
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
