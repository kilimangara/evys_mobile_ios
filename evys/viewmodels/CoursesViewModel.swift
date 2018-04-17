//
//  CoursesViewModel.swift
//  evys
//
//  Created by Nikita Zlain on 15.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class CoursesViewModel {
    
    var data: Driver<[Course]>
    
    init(refresh: UIRefreshControl){
        let initial = APIProvider.sharedInstance.getSubjects()
        let refreshable = refresh.rx.controlEvent(.valueChanged)
                      .flatMap({_ in return APIProvider.sharedInstance.getSubjects()})
                      .do(onNext:{_ in refresh.endRefreshing()})
        data = Observable.of(initial, refreshable).merge().asDriver(onErrorJustReturn: [])
    }
    
}
