//
//  RefreshViewModel.swift
//  evys
//
//  Created by Nikita Zlain on 17.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RefreshViewModel {
    
    public let refreshControl : UIRefreshControl!
    
    let disposables = DisposeBag()
    
    init(observableToListen: Observable<Bool>){
        self.refreshControl = UIRefreshControl()
        observableToListen.subscribe({event in
            switch event {
            case .next(_):
                print("onNExt refresh")
                self.refreshControl.endRefreshing()
            case .error(_):
                print("onErrorRefresh")
                self.refreshControl.endRefreshing()
            case .completed:
                print("OnComplete REFRESH")
            }
        }).disposed(by: disposables)
    }
}
