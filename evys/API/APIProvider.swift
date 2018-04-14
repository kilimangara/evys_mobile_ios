//
//  APIProvider.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class APIProvider {
    
    private let BASE_URL = "https://api.evys.ru/"
    
    public func sendCode(phone: String) -> Observable<Void> {
        guard phone.isEmpty, let url = URL(string: self.BASE_URL + "student/code") else {return Observable.empty()}
        return Observable<Void>.create({observer in
            let parameters: Parameters = ["phone": phone]
            Alamofire.request(url, method: .post, parameters: parameters).responseJSON{ response in
                switch response.result {
                case .success:
                    observer.onNext(Void())
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }

    public func authStudent(phone: String, code: String) -> Observable<AuthModel> {
        let url = URL(string: self.BASE_URL + "student/auth")
        return Observable.create({observer in
            let parameters: Parameters = ["phone": phone, "code": code]
            Alamofire.request(url!, method:.post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    let result = response.result
                    if let dict = result.value as? Dictionary<String, AnyObject> {
                        let innerDict = dict["data"] as! Dictionary<String, AnyObject>
                        observer.onNext(AuthModel(dict:innerDict))
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
}
