//
//  ThemesViewModel.swift
//  evys
//
//  Created by Nikita Zlain on 18.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class ThemesViewModel {
    
    var data: Driver<[ThemeModel]>
    
    init(courseId: Int, refresh: UIRefreshControl){
        let initial = APIProvider.sharedInstance.getThemes(courseId: courseId)
        let refreshable = refresh.rx.controlEvent(.valueChanged)
            .flatMap({_ in return APIProvider.sharedInstance.getThemes(courseId: courseId)})
            .do(onNext:{_ in refresh.endRefreshing()})
        data = Observable.of(initial, refreshable).merge().asDriver(onErrorJustReturn: [])
    }
    
}
