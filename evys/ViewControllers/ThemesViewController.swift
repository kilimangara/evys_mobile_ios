//
//  ThemesViewController.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ThemesViewController: UIViewController {
    
    var courseModel: Course!
    
    var themesViewModel : ThemesViewModel?
    var refreshControl : UIRefreshControl!
    
    let disposables = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()
        refreshControl = UIRefreshControl()
        themesViewModel = ThemesViewModel(courseId: courseModel.id, refresh: refreshControl)
        if let viewModel = themesViewModel {
            collectionView.addSubview(refreshControl)
            viewModel.data.drive(collectionView.rx.items(cellIdentifier: "themeCell")) {
                index, theme, cell in
                if let themeCell = cell as? ThemesCollectionViewCell{
                    themeCell.setDynamicValues(themeModel: theme)
                    themeCell.prepareView()
                    themeCell.prepareForAppearance(boundsWidth: self.collectionView.bounds.width, index: index)
                }
            }.disposed(by: disposables)
        }
        collectionView.rx.modelSelected(ThemeModel.self).subscribe(onNext: {
            theme in
            if let preTestViewController = self.storyboard?.instantiateViewController(withIdentifier: "PreTestViewController") as? PreTestViewController {
                preTestViewController.theme = theme
                self.navigationController?.pushViewController(preTestViewController, animated: true)
            }
        }).disposed(by: self.disposables)
        
        // Do any additional setup after loading the view.
    }
    
    func setupBar(){
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = courseModel.subjectName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
