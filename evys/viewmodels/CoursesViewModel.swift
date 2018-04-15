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

struct CoursesViewModel {
    
    var data: Driver<[Course]>
    
    init(){
        data = APIProvider.sharedInstance.getSubjects().asDriver(onErrorJustReturn: [])
    }
}
