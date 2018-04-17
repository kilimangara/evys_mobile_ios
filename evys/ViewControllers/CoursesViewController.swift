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

class CustomFlowLayout : UICollectionViewLayout {
    var insertingIndexPaths = [IndexPath]()
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        
        for update in updateItems {
            if let indexPath = update.indexPathAfterUpdate,
                update.updateAction == .insert {
                insertingIndexPaths.append(indexPath)
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        //if insertingIndexPaths.contains(itemIndexPath) {
        attributes?.alpha = 0.0
        attributes?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        //attributes?.transform = CGAffineTransform(translationX: 0, y: 500.0)
    
        //}
        
        return attributes
    }
}

class CoursesViewController: UIViewController {
    
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    var coursesViewModel : CoursesViewModel?
    var refreshControl : UIRefreshControl!
    
    let disposables = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
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
        }
        
        coursesCollectionView.rx.modelSelected(Course.self).subscribe(onNext: {
            course in
            print(course.subjectName)
            if let themeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThemesViewController") as? ThemesViewController {
                themeViewController.courseModel = course
                self.navigationController?.pushViewController(themeViewController, animated: true)
            }
        }).disposed(by: self.disposables)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

}
