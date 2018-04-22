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
import BusyNavigationBar

class CoursesViewController: UIViewController {
    
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    var coursesViewModel : CoursesViewModel?
    var refreshControl : UIRefreshControl!
    
    let disposables = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()
        navigationItem.largeTitleDisplayMode = .automatic
        refreshControl = UIRefreshControl()
        coursesViewModel = CoursesViewModel(refresh: refreshControl)
        if let viewModel = coursesViewModel {
            coursesCollectionView.addSubview(refreshControl)
            viewModel.data.drive(coursesCollectionView.rx.items(cellIdentifier: "courseCell")) {
                index, course, cell in
                if let courseCell = cell as? CourseTableViewCell{
                    courseCell.setSubjectName(name: course.subjectName)
                    courseCell.prepareView()
                    courseCell.prepareForAppearance(boundsWidth: self.coursesCollectionView.bounds.width, index: index)
                }
            }.disposed(by: self.disposables)
            
            viewModel.data.asObservable().subscribe({
                event in
                switch event {
                case .next(let courses):
                    print("ONNEXT", courses)
                    if courses.isEmpty {
                        self.coursesCollectionView.setEmptyMessage("PRIVET PIDOR")
                    } else {
                        self.coursesCollectionView.restore()
                    }
                case .error(let error):
                    print("ONERROR", error)
                    self.coursesCollectionView.setEmptyMessage("PRIVET PIDOR")
                case .completed: break
                }
            }).disposed(by: self.disposables)
        }
        
        coursesCollectionView.rx.modelSelected(Course.self).subscribe(onNext: {
            course in
            print(course.subjectName)
            if let themeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThemesViewController") as? ThemesViewController {
                themeViewController.courseModel = course
                self.navigationController?.pushViewController(themeViewController, animated: true)
            }
        }).disposed(by: self.disposables)
        
        coursesCollectionView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            if let courseCell = self.coursesCollectionView.cellForItem(at: indexPath) as? CourseTableViewCell {
                courseCell.cellSelected()
            }
        }).disposed(by: self.disposables)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBar(){
        let options = BusyNavigationBarOptions()
        
        /**
         Animation type
         
         - Stripes: Sliding stripes as seen in Periscope app.
         - Bars: Bars going up and down like a wave.
         - CustomLayer(() -> CALayer): Your layer to be inserted in navigation bar. In this case, properties other than `transparentMaskEnabled` and `alpha` will not be used.
         */
        options.animationType = .stripes
        
        /// Color of the shapes. Defaults to gray.
        options.color = UIColor.gray
        
        /// Alpha of the animation layer. Remember that there is also an additional (constant) gradient mask over the animation layer. Defaults to 0.5.
        options.alpha = 1.0
        
        /// Width of the bar. Defaults to 20.
        options.barWidth = 20
        
        /// Gap between bars. Defaults to 30.
        options.gapWidth = 30
        
        /// Speed of the animation. 1 corresponds to 0.5 sec. Defaults to 1.
        options.speed = 1
        
        /// Flag for enabling the transparent masking layer over the animation layer.
        options.transparentMaskEnabled = true

    }

}
